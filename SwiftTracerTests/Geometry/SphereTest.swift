//
//  SphereTest.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftTracer

class SphereTests: XCTestCase {
    let sphere = Sphere(radius: 2.0, center: Vector(x: 0.0, y: 0.0, z: 0.0))

    func testMiss() {
        let ray = Ray(origin: Vector(x: 0.0, y: 0.0, z: -5.0), direction: Vector(x: 1.0, y: 0.0, z: 0.0))

        let intersection = sphere.intersectWithRay(ray)
        XCTAssertTrue(intersection == nil)
    }

    func testHit() {
        let ray = Ray(origin: Vector(x: 0.0, y: 0.0, z: -5.0), direction: Vector(x: 0.0, y: 0.0, z: 1.0))
        let intersection = sphere.intersectWithRay(ray)

        XCTAssertTrue(intersection != nil)
        let i = intersection!
        XCTAssertEqualWithAccuracy(i.t, 3.0, accuracy: 0.001)
        XCTAssertTrue(i.point.fuzzyEquals(Vector(x: 0.0, y: 0.0, z: -2.0)))
        XCTAssertTrue(i.normal.fuzzyEquals(Vector(x: 0.0, y: 0.0, z: 1.0)))
    }
}

