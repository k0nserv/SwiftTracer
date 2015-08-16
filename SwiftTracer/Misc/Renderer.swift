//
//  Renderer.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

protocol RendererDelegate {
    func didFinishRendering(pixels: [[Color]])
}

struct Renderer {
    let scene: Scene
    let depth: Int
    var camera: Camera
    var pixels: [[Color]]
    var delegate: RendererDelegate?
    private var isRendering = false

    init(scene: Scene, camera: Camera, depth: Int) {
        self.scene = scene
        self.camera = camera
        self.pixels = []
        self.depth = depth
    }

    mutating func render() {
        isRendering = true
        var result: [[Color]] = []

        for var x = 0; x < camera.width; ++x {
            result.append([])
            for var y = 0; y < camera.height; ++y {
                if !isRendering {
                    return
                }

                let ray = camera.createRay(x: x, y: y)
                let color = traceRay(ray, depth: depth)
                result[x].append(color)
            }
        }

        pixels = result

        if let d = delegate {
            d.didFinishRendering(pixels)
        }
        isRendering = false
    }

    mutating func abortRendering() {
        isRendering = false
    }

    private mutating func traceRay(ray: Ray, depth: Int) -> Color {
        var result = scene.clearColor
        var closestHit: Intersection?

        for var object in scene.objects {
            if let hit = object.intersectWithRay(ray) {
                if  let previousHit = closestHit where hit.t < previousHit.t  {
                    closestHit = hit
                } else if closestHit == nil {
                    closestHit = hit
                }
            }
        }

        if let hit = closestHit {
            result = shade(hit)
        }


        return result
    }

    private func shade(intersection: Intersection) -> Color {
        let material = intersection.shape.material
        var result = material.color * material.ambientCoefficient

        for var light in scene.lights {
            var inShadow = false
            let distanceToLight = (intersection.point - light.position).length()
            let lightDirection = (intersection.point - light.position).normalize()
            let ray = Ray(origin: intersection.point, direction: lightDirection)

            for var object in scene.objects {
                if let hit = object.intersectWithRay(ray) where hit.t < distanceToLight {
                    inShadow = true
                    break
                }
            }

            var dot = lightDirection.dot(intersection.normal)
            if dot < 0 || inShadow {
                dot = 0
            }

            result = result + (light.color * light.intensity) * (dot * material.diffuseCoefficient)
        }
        return result.clamp()
    }
}