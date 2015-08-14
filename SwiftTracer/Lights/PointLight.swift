//
//  PointLight.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

class PointLight {
    let color: Color
    let position: Vector
    let intensity: Double

    init(color: Color, position: Vector, intensity: Double) {
        self.color = color
        self.position = position
        self.intensity = intensity
    }
}