//
//  Color.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

#if os(Linux)
  import Glibc
#else
  import Darwin.C
#endif

public typealias Color = UInt32

public extension Color {
    public static let Black = Color(r: 0.0, g: 0.0, b: 0.0)

    public var r: UInt8 {
        get {
            return UInt8((self & 0x000000FF) >> 0)
        }
    }

    public var g: UInt8 {
        get {
            return UInt8((self & 0x0000FF00) >> 8)
        }
    }

    public var b: UInt8 {
        get {
            return UInt8((self & 0x00FF0000) >> 16)
        }
    }

    public var a: UInt8 {
        get {
            return UInt8((self & 0xFF000000) >> 24)
        }
    }

    public var rd: Double {
        get {
            return Double(r) / 255.0
        }
    }

    public var gd: Double {
        get {
            return Double(g) / 255.0
        }
    }

    public var bd: Double {
        get {
            return Double(b) / 255.0
        }
    }


    public init(r: UInt8, g: UInt8, b: UInt8) {
        self = 0xFF000000
        self = self | UInt32(r) << 0
        self = self | UInt32(g) << 8
        self = self | UInt32(b) << 16
    }

    public init(r: Double, g: Double, b: Double) {
        let rNormalized = Color.clampValue(Int32(255.0 * r))
        let gNormalized = Color.clampValue(Int32(255.0 * g))
        let bNormalized = Color.clampValue(Int32(255.0 * b))

        self.init(r: rNormalized,
                  g: gNormalized,
                  b: bNormalized)
    }

    public init(_ color: UInt32) {
        self = color
    }

    private static func clampValue(value: Int32) -> UInt8 {
        if value < 0 {
            return 0
        }

        if value > UINT8_MAX {
            return UInt8(UINT8_MAX)
        }

        return UInt8(value)
    }
}


public func *(left: Color, right: Double) -> Color {
    return Color(r: Color.clampValue(Int32(Double(left.r) * right)),
        g: Color.clampValue(Int32(Double(left.g) * right)),
        b: Color.clampValue(Int32(Double(left.b) * right)))
}

public func *(left: Color, right: Color) -> Color {
    return Color(r: left.rd * right.rd, g: left.gd * right.gd, b: left.bd * right.bd)
}

public func +(left: Color, right: Color) -> Color {
    return Color(r: Color.clampValue(Int32(left.r) + Int32(right.r)), g: Color.clampValue(Int32(left.g) + Int32(right.g)) , b: Color.clampValue(Int32(left.b) + Int32(right.b)))
}


public func -(left: Color, right: Color) -> Color {
    return Color(r: Color.clampValue(Int32(left.r) - Int32(right.r)), g: Color.clampValue(Int32(left.g) - Int32(right.g)) , b: Color.clampValue(Int32(left.b) - Int32(right.b)))
}
