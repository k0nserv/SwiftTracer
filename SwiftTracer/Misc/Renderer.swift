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

struct Renderer {
    private static let epsilon: Double = 1e-10
    let scene: Scene
    let depth: Int
    var camera: Camera
    var pixels: [Color]
    var delegate: RendererDelegate?
    private var isRendering = false
    var startTime: NSDate = NSDate()

    init(scene: Scene, camera: Camera, depth: Int) {
        self.scene = scene
        self.camera = camera
        self.pixels = []
        self.depth = depth
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

                let ray = camera.createRay(x: x, y: y)
                let color = traceRay(ray, depth: depth)
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
                result[index] = color
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
            return Color(r: 0.0, g: 0.0, b: 0.0)
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