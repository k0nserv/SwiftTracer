//
//  Camera.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation


struct Camera {
    let position: Vector
    let direction: Vector
    let up = Vector(x: 0.0, y: 1.0, z: 0.0)
    let fov: Double
    let width: Int
    let height: Int
    let U: Vector
    let V: Vector

    init(position: Vector, direction: Vector, fov: Double, width: Int, height: Int) {
        self.position = position
        self.direction = direction
        self.fov = fov
        self.width = width
        self.height = height
        U = direction.cross(up).normalize()
        V = U.cross(direction).normalize()
    }

    func createRay(x x: Int, y: Int) -> Ray {
        let normalizedX = (Double(x) / Double(width)) - 0.5
        let normalizedY = (Double(y) / Double(height)) - 0.5
        let imagePoint =  U * normalizedX + V * normalizedY + position + direction
        
        return Ray(origin: position, direction: (imagePoint - self.position).normalize())
    }

    func cameraWithNewResolution(newWidth newWidth: Int, newHeight: Int) -> Camera {
        return Camera(position: self.position, direction: self.direction, fov: self.fov, width: newWidth, height: newHeight)
    }
}