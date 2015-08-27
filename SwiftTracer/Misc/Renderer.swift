//
//  Renderer.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

protocol RendererDelegate {
    func didFinishRendering(pixels: [Color], duration: NSTimeInterval)
}

enum SuperSampling {
    case Off
    // Number of samples per dimensions
    // Example: On(4) is 4x4, 4 samples for x and 4 for y
    case On(UInt)
}

struct Renderer {
    private static let epsilon: Double = 1e-12
    let scene: Scene
    let depth: Int
    var camera: Camera
    var pixels: [Color]
    var delegate: RendererDelegate?
    var superSampling: SuperSampling {
        didSet {
            switch superSampling {
            case .Off:
                samplesPerPixel = 1
            case .On(let samplesPerPixel):
                self.samplesPerPixel = samplesPerPixel
            }
        }
    }
    var startTime: NSDate = NSDate()
    private var samplesPerPixel: UInt
    private var isRendering = false

    init(scene: Scene, camera: Camera, depth: Int) {
        self.scene = scene
        self.camera = camera
        self.pixels = []
        self.depth = depth
        self.superSampling = .Off
        self.samplesPerPixel = 1
    }

    mutating func render() {
        isRendering = true
        var result: [Color] = Array(count: camera.width * camera.height, repeatedValue: scene.clearColor)
        startTime = NSDate()


        for var y = 0; y < camera.height; ++y {
            for var x = 0; x < camera.width; ++x {
                if !isRendering {
                    return
                }

                var colors: [Color] = Array(count: Int(samplesPerPixel*samplesPerPixel), repeatedValue: scene.clearColor)
                for var xSample = UInt(0); xSample < samplesPerPixel; ++xSample {
                    for var ySample = UInt(0); ySample < samplesPerPixel; ++ySample {
                        let ray = camera.createRay(x: x, y: y, xSample: xSample, ySample: ySample, samplesPerPixel: samplesPerPixel)
                        colors[Int(ySample * samplesPerPixel + xSample)] = traceRay(ray, depth: depth)
                    }
                }

                let index = (camera.height - 1 - y) * camera.width + x
                if index > result.count {
                    // HACK: When isRendering is turned off in another
                    // thread the next line might still cause an index out of bounds
                    // error. This fixes the problem slightly, but it's a
                    // horrible solution.
                    // TODO: Think of a better way to deal with interupting rendering
                    // midway and doing rendering in the background
                    return
                }
                var avgR = 0.0
                var avgG = 0.0
                var avgB = 0.0

                for c in colors {
                    avgR += c.rd
                    avgG += c.gd
                    avgB += c.bd
                }

                result[index] = Color(r: avgR / Double(colors.count),
                                      g: avgG / Double(colors.count),
                                      b: avgB / Double(colors.count))
            }
        }

        pixels = result

        if let d = delegate {
            let duration = NSDate().timeIntervalSinceDate(startTime)
            d.didFinishRendering(pixels, duration: duration)
        }
        isRendering = false
    }

    mutating func abortRendering() {
        isRendering = false
    }

    private mutating func traceRay(ray: Ray, depth: Int) -> Color {
        if depth == 0 {
            return Color.Black
        }

        var result = scene.clearColor
        var closestHit: Intersection?

        for object: Shape in scene.objects {
            if let hit = object.intersectWithRay(ray) {
                if  let previousHit = closestHit where hit.t < previousHit.t  {
                    closestHit = hit
                } else if closestHit == nil {
                    closestHit = hit
                }
            }
        }

        if let hit = closestHit {
            result = shade(hit, originalRay: ray)
            if hit.shape.material.isReflective {
                let newDirection = ray.direction.reflect(hit.normal).normalize()
                let newRay = Ray(origin: hit.point + hit.point * newDirection * Renderer.epsilon,
                              direction: newDirection)
                let reflectiveColor = traceRay(newRay, depth: depth - 1)
                result = result + reflectiveColor * hit.shape.material.reflectionCoefficient
            }

            if var refractionCoefficient = hit.shape.material.refractionCoefficient {
                if hit.inside { // Leaving refractive material
                    refractionCoefficient = 1.0
                }
                let n = ray.mediumRefractionIndex / refractionCoefficient
                var N = hit.normal
                if hit.inside {
                    N = -N
                }
                let cosI = (N.dot(ray.direction))
                let c2 = 1.0 - n * n * (1.0 - cosI * cosI)
                if c2 > 0.0 {
                    let T = (ray.direction * n + N * (n * cosI - sqrt(c2))).normalize()
                    let newRay = Ray(origin: hit.point + hit.point * T * Renderer.epsilon,
                                  direction: T,
                      mediumRefractionIndex: refractionCoefficient)
                    let refractionColor = traceRay(newRay, depth: depth - 1)
                    let absorbance = hit.shape.material.color * 0.15 * -hit.t
                    let transparency = Color(r: exp(absorbance.rd), g: exp(absorbance.gd), b: exp(absorbance.bd))
                    result = result + refractionColor * transparency
                }
            }
        }


        return result
    }

    private func shade(intersection: Intersection, originalRay: Ray) -> Color {
        let material = intersection.shape.material
        var result = material.color * material.ambientCoefficient

        for light in scene.lights {
            var inShadow = false
            let distanceToLight = (intersection.point - light.position).length()
            let lightDirection = (light.position - intersection.point).normalize()
            let ray = Ray(origin: intersection.point + lightDirection * Renderer.epsilon,
                       direction: lightDirection)

            for object in scene.objects {
                if let hit = object.intersectWithRay(ray) where hit.t < distanceToLight {
                    inShadow = true
                    break
                }
            }

            let lightColor = light.color * light.intensity
            var dot = lightDirection.dot(intersection.normal)
            if dot > 0 && !inShadow {
                result = result + lightColor * (dot * material.diffuseCoefficient)
            }

            dot = originalRay.direction.dot(lightDirection.reflect(intersection.normal))
            if dot > 0 && !inShadow {
                let spec = pow(dot, 20) * material.specularCoefficient
                result = result + lightColor * spec
            }
        }
        return result
    }
}