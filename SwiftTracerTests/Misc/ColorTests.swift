//
//  Color.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 19/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import XCTest
@testable import SwiftTracer

class ColorTests: XCTestCase {
    let c = Color(r: UInt8(230), g: UInt8(190), b: UInt8(25))
    let a = Color(r: 1.2, g: 0.5, b: -0.5)

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit() {
        XCTAssertEqual(c, Color(0xE6BE19FF))
    }

    func testDoubleInit() {
        XCTAssertEqual(a, 0xFF7F00FF, "Init with double values should work and correctly clamp values")
    }

    /* Not working due to Typing
    func testAddition() {
        let sum: Color = Color(a + c)
        XCTAssertEqual(sum, 0xFFFF19FF)
    }

    func testSubtraction() {
        let sum: Color = Color(a + c)
        XCTAssertEqual(sum, 0xFFFF19FF)
    }*/

    func testProperties() {
        XCTAssertEqual(c.r, 230)
        XCTAssertEqual(c.g, 190)
        XCTAssertEqual(c.b, 25)

        XCTAssertEqual(a.r, 255)
        XCTAssertEqual(a.g, 127)
        XCTAssertEqual(a.b, 0)
    }
}
