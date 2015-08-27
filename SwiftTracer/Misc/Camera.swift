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
    let width: Int
    let height: Int
    let aspectRatio: Double

    private let x0: Double
    private let y0: Double

    init(fov: Double, width: Int, height: Int) {
        self.fov = fov
        self.width = width
        self.height = height
        self.aspectRatio = Double(height) / Double(width)
        let verticalFov = self.fov * aspectRatio
        self.x0 = sin(fov * 0.5)
        self.y0 = sin(verticalFov * 0.5)
    }

    func createRay(x x: Int, y: Int, xSample: UInt, ySample: UInt, samplesPerPixel: UInt) -> Ray {
        let sampleWidth = Double(width * Int(samplesPerPixel))
        let sampleHeight = Double(height * Int(samplesPerPixel))
        let px = (Double(x * Int(samplesPerPixel) + Int(xSample)) * 2) / sampleWidth - 1
        let py = (Double(y * Int(samplesPerPixel) + Int(ySample)) * 2) / sampleHeight - 1
        let direction = Vector(x: px * x0, y: py * y0, z: 1.0)

        return Ray(origin: Vector(x: 0, y: 0, z: 0), direction: direction.normalize())
    }

    func cameraWithNewResolution(newWidth newWidth: Int, newHeight: Int) -> Camera {
        return Camera(fov: self.fov, width: newWidth, height: newHeight)
    }
}