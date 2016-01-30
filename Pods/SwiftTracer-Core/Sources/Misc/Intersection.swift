//
//  Intersection.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

public class Intersection {
    public let t: Double
    public let point: Vector
    public let normal: Vector
    public let shape: Shape
    // Wether or not the hit is
    // from inside the shape itself
    public let inside: Bool

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
