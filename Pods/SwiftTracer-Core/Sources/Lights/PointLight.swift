//
//  PointLight.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

public class PointLight {
    public let color: Color
    public let position: Vector
    public let intensity: Double

    public init(color: Color, position: Vector, intensity: Double) {
        self.color = color
        self.position = position
        self.intensity = intensity
    }
}