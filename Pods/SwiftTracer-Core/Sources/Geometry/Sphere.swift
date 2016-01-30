//
//  Sphere.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

#if os(Linux)
  import Glibc
#else
  import Darwin.C
#endif

public class Sphere {
    public let radius: Double
    public let center: Vector
    public let material: Material

    public init(radius: Double, center: Vector, material: Material) {
        self.radius = radius
        self.center = center
        self.material = material
    }
}

extension Sphere : Shape {
    public func intersectWithRay(ray: Ray) -> Intersection? {
        let V = ray.origin - center
        let a = ray.direction.dot(V)
        let b = -a
        let c = pow(a, 2) - pow(V.length(), 2) + pow(radius, 2)

        if (c < 0) {
            return nil
        }

        let t1 = b + sqrt(c)
        let t2 = b - sqrt(c)

        var t: Double?
        var hit = false
        var inside = false

        if t1 > 0.01 {
            if t2 < 0.0 {
                t = t1
                hit = true
                inside = true
            } else {
                t = t2
                hit = true
            }
        }

        if hit {
            assert(nil != t)
            let intersectionPoint = ray.origin + ray.direction * t!
            let N = (intersectionPoint - center).normalize()
            return Intersection(t: t!, point: intersectionPoint, normal: N, shape: self, inside: inside)
        }

        return nil
    }
}
