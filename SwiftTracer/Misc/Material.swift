//
//  Material.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

class Material {
    var color: Color = Color.Black
    var ambientCoefficient: Double = 0.2
    var diffuseCoefficient: Double = 0.2
    var specularCoefficient: Double = 0.0

    var reflectionCoefficient: Double = 0.0
    var isReflective: Bool {
        get {
            return reflectionCoefficient > 0.0
        }
    }

    var refractionCoefficient: Double?

    convenience init(color: Color, ambientCoefficient: Double, diffuseCoefficient: Double) {
        self.init(color: color, ambientCoefficient: ambientCoefficient, diffuseCoefficient: diffuseCoefficient, specularCoefficient: 0.0, reflectionCoefficient: 0.0, refractionCoefficient: nil)
    }

    init(color: Color, ambientCoefficient: Double, diffuseCoefficient: Double, specularCoefficient: Double, reflectionCoefficient: Double, refractionCoefficient: Double?) {
        self.color = color
        self.ambientCoefficient = ambientCoefficient
        self.diffuseCoefficient = diffuseCoefficient
        self.specularCoefficient = specularCoefficient
        self.reflectionCoefficient = reflectionCoefficient
        self.refractionCoefficient = refractionCoefficient
    }

    func copy() -> Material {
        return Material(color: color, ambientCoefficient: ambientCoefficient, diffuseCoefficient: diffuseCoefficient, specularCoefficient: specularCoefficient, reflectionCoefficient: reflectionCoefficient, refractionCoefficient: refractionCoefficient)
    }
}