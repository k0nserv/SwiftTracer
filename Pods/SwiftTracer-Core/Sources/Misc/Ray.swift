//
//  Ray.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

public struct Ray {
    public let origin: Vector
    public let direction: Vector

    // The refraction index of the medium
    // in which the ray's origin resides
    public let mediumRefractionIndex: Double

    public init(origin: Vector, direction: Vector) {
        self.init(origin: origin, direction: direction, mediumRefractionIndex: 1.0)
    }

    public init(origin: Vector, direction: Vector, mediumRefractionIndex: Double) {
        self.origin = origin
        self.direction = direction
        self.mediumRefractionIndex = mediumRefractionIndex
    }
}
