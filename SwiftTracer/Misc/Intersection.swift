//
//  Intersection.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation


struct Intersection {
    let t: Double
    let point: Vector
    let normal: Vector
    let shape: Shape
    // Wether or not the hit is
    // from inside the shape itself
    let inside: Bool
}
