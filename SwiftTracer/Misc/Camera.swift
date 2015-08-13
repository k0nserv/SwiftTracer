//
//  Camera.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation


struct Camera {
    let fov: Double
    let verticalFov: Double
    let width: Int
    let height: Int
    let aspectRatio: Double

    init(fov: Double, width: Int, height: Int) {
        self.fov = fov
        self.width = width
        self.height = height
        self.aspectRatio = Double(height) / Double(width)
        self.verticalFov = self.fov * aspectRatio
    }

    func createRay(x x: Int, y: Int) -> Ray {
        let px = Double(x) * 2 / Double(width) - 1
        let py = Double(y) * 2 / Double(height) - 1
        let direction = Vector(x: px * sin(fov * 0.5), y: py * sin(verticalFov * 0.5), z: 1.0)

        return Ray(origin: Vector(x: 0, y: 0, z: 0), direction: direction.normalize())
    }

    func cameraWithNewResolution(newWidth newWidth: Int, newHeight: Int) -> Camera {
        return Camera(fov: self.fov, width: newWidth, height: newHeight)
    }
}