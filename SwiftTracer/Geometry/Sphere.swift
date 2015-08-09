//
//  Sphere.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation


struct Sphere {
    let radius: Double
    let center: Vector
    let material: Material
}

extension Sphere : Shape {
    func intersectWithRay(ray: Ray) -> Intersection? {
        let d = ray.origin - center
        let a = (ray.direction.dot(d))
        let b = pow(d.length(), 2) - pow(radius, 2)
        let c = pow(a, 2) - b

        if (c < 0) {
            return nil
        }

        let t1 = -a + sqrt(c)
        let t2 = -a - sqrt(c)

        var t: Double?
        var hit = false
        if t1 > 0.01 && t1 < t2 {
            t = t1
            hit = true
        } else if t2 > 0.01 && t2 < t1 {
            t = t2
            hit = true
        }

        if hit {
            assert(nil != t)
            let intersectionPoint = ray.origin + ray.direction * t!
            let normal = (intersectionPoint - ray.origin).normalize()
            return Intersection(t: t!, point: intersectionPoint, normal: normal, shape: self)
        }

        return nil
    }
}
