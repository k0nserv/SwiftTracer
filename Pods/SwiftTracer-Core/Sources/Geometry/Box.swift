//
//  Box.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 31/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

public class Box {
    public let material: Material
    public let min: Vector
    public let max: Vector

    public init(min: Vector, max: Vector, material: Material) {
        self.min = min
        self.max = max
        self.material = material
    }
}

extension Box: Shape {
    public func intersectWithRay(ray: Ray) -> Intersection? {
        var tmin, tmax, tymin, tymax, tzmin, tzmax: Double

        if ray.direction.x >= 0 {
            tmin = (min.x - ray.origin.x) / ray.direction.x
            tmax = (max.x - ray.origin.x) / ray.direction.x
        } else {
            tmin = (max.x - ray.origin.x) / ray.direction.x
            tmax = (min.x - ray.origin.x) / ray.direction.x
        }

        if ray.direction.y >= 0 {
            tymin = (min.y - ray.origin.y) / ray.direction.y
            tymax = (max.y - ray.origin.y) / ray.direction.y
        } else {
            tymin = (max.y - ray.origin.y) / ray.direction.y
            tymax = (min.y - ray.origin.y) / ray.direction.y
        }

        if tmin > tymax || tymin > tmax {
            return nil
        }

        if tymin >  tmin {
            tmin = tymin
        }

        if tymax < tmax {
            tmax = tymax
        }

        if ray.direction.z >= 0 {
            tzmin = (min.z - ray.origin.z) / ray.direction.z
            tzmax = (max.z - ray.origin.z) / ray.direction.z
        } else {
            tzmin = (max.z - ray.origin.z) / ray.direction.z
            tzmax = (min.z - ray.origin.z) / ray.direction.z
        }

        if tmin > tzmax || tzmax > tmax {
            return nil
        }

        if tzmin > tmin {
            tmin = tzmin
        }
        if (tzmax < tmax) {
            tmax = tzmax
        }

        let center = Vector(x: max.x - min.x, y: max.y - min.y, z: max.z - min.z)
        let hitPoint = ray.origin + ray.direction * tmin
        return Intersection(t: tmin, point: hitPoint, normal: (hitPoint - center).normalize(), shape: self)
    }
}