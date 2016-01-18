//
//  Intersection.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

class Intersection {
    let t: Double
    let point: Vector
    let normal: Vector
    let shape: Shape
    // Wether or not the hit is
    // from inside the shape itself
    let inside: Bool

    convenience init (t: Double, point: Vector, normal: Vector, shape: Shape) {
        self.init(t: t, point: point, normal: normal, shape: shape, inside: false)
    }


    init(t: Double, point: Vector, normal: Vector, shape: Shape, inside: Bool) {
        self.t = t
        self.point = point
        self.normal = normal
        self.shape = shape
        self.inside = inside
    }
}
