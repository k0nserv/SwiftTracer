//
//  Renderer.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation


struct Renderer {
    let scene: Scene
    var camera: Camera

    init(scene: Scene, camera: Camera) {
        self.scene = scene
        self.camera = camera
    }

    func render() -> [[Color]] {
        var result: [[Color]] = []

        for var x = 0; x < camera.width; ++x {
            result.append([])
            for var y = 0; y < camera.height; ++y {
                let ray = camera.createRay(x: x, y: y)
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
                    result[x].append(hit.shape.material.color)
                } else {
                    result[x].append(Color(r: 0.0, g: 0.0, b: 0.0))
                }
            }
        }

        return result
    }
}