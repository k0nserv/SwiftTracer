//
//  Scene.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

public class Scene {
    public let objects: [Shape]
    public let lights: [PointLight]
    public let clearColor: Color

    public init(objects: [Shape], lights: [PointLight], clearColor: Color) {
        self.objects = objects
        self.lights = lights
        self.clearColor = clearColor
    }


    public func intersect(ray: Ray) -> Intersection? {
        var closestHit: Intersection?

        for object: Shape in objects {
            if let hit = object.intersectWithRay(ray) {
                if  let previousHit = closestHit where hit.t < previousHit.t  {
                    closestHit = hit
                } else if closestHit == nil {
                    closestHit = hit
                }
            }
        }

        return closestHit
    }
}
