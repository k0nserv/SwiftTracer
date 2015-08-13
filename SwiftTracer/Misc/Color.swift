//
//  Color.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

struct Color {
    let r: Double
    let g: Double
    let b: Double

    func clamp() -> Color {
        return Color(r: max(min(1.0, r), 0.0), g: max(min(1.0, g), 0), b: max(min(1.0, b), 0))
    }
}

func *(left: Color, right: Double) -> Color {
    return Color(r: left.r * right, g: left.g * right, b: left.b * right)
}

func +(left: Color, right: Color) -> Color {
    return Color(r: left.r + right.r, g: left.g + right.g , b: left.b + right.b)
}

func -(left: Color, right: Color) -> Color {
    return Color(r: left.r - right.r, g: left.g - right.g , b: left.b - right.b)
}