//
//  VectorTests.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import XCTest
@testable import SwiftTracer

class VectorTests: XCTestCase {

    let v1 = Vector(x: 1.0, y: 2.5, z: 8.1)
    let v2 = Vector(x: 8.9, y: 1.2, z: 0.9)

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDotProduct() {
        let dot = v1.dot(v2)
        XCTAssertEqual(dot, 19.19)
    }

    func testLenght() {
        let unit = Vector(x: 1.0, y: 0.0, z: 0.0)
        XCTAssertEqualWithAccuracy(unit.length(), 1.0, accuracy: 0.001)

        XCTAssertEqualWithAccuracy(v1.length(), 8.535806933, accuracy: 0.001)
    }

    func testPrefixSubtraction() {
        let inverted = -v1
        XCTAssertEqual(inverted, Vector(x: -1.0, y: -2.5, z: -8.1))
    }

    func testInfixSubstraction() {
        let other = v1 - v2

        let equal = other.fuzzyEquals(Vector(x: -7.9, y: 1.3, z: 7.2))
        XCTAssertTrue(equal)
    }

    func testInfixAddition() {
        let other = v1 + v2

        let equal = other.fuzzyEquals(Vector(x: 9.9, y: 3.7, z: 9.0))
        XCTAssertTrue(equal)
    }

    func testMultiplicationWithDouble() {
        let other = v1 * 2
        XCTAssertEqual(other, Vector(x: 2.0, y: 5.0, z: 16.2))
    }

}
