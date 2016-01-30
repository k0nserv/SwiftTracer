//
//  Plane.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation


public class Plane {
    public let position: Vector
    public let normal: Vector
    public let material: Material

    public init(position: Vector, normal: Vector, material: Material) {
        self.position = position
        self.normal = normal
        self.material = material
    }
}

extension Plane : Shape {
    public func intersectWithRay(ray: Ray) -> Intersection? {
        let denominator = normal.dot(ray.direction)
        if abs(denominator) < 1e-5 {
            return nil
        }

        let t = (position - ray.origin).dot(normal) / denominator

        if t >= 1e-5 {
            let intersectionPoint = ray.origin + ray.direction * t
            return Intersection(t: t, point: intersectionPoint, normal: normal, shape: self)
        }

        return nil
    }
}
