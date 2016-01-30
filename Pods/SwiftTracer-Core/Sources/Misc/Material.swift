//
//  Material.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

public class Material {
    public var color: Color = Color.Black
    public var ambientCoefficient: Double = 0.2
    public var diffuseCoefficient: Double = 0.2
    public var specularCoefficient: Double = 0.0

    public var reflectionCoefficient: Double = 0.0
    public var isReflective: Bool {
        get {
            return reflectionCoefficient > 0.0
        }
    }

    public var refractionCoefficient: Double?

    public convenience init(color: Color, ambientCoefficient: Double, diffuseCoefficient: Double) {
        self.init(color: color, ambientCoefficient: ambientCoefficient, diffuseCoefficient: diffuseCoefficient, specularCoefficient: 0.0, reflectionCoefficient: 0.0, refractionCoefficient: nil)
    }

    public init(color: Color, ambientCoefficient: Double, diffuseCoefficient: Double, specularCoefficient: Double, reflectionCoefficient: Double, refractionCoefficient: Double?) {
        self.color = color
        self.ambientCoefficient = ambientCoefficient
        self.diffuseCoefficient = diffuseCoefficient
        self.specularCoefficient = specularCoefficient
        self.reflectionCoefficient = reflectionCoefficient
        self.refractionCoefficient = refractionCoefficient
    }

    public func copy() -> Material {
        return Material(color: color, ambientCoefficient: ambientCoefficient, diffuseCoefficient: diffuseCoefficient, specularCoefficient: specularCoefficient, reflectionCoefficient: reflectionCoefficient, refractionCoefficient: refractionCoefficient)
    }
}