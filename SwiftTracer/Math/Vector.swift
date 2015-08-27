//
//  Vector.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation

struct Vector : Equatable  {
    let x: Double
    let y: Double
    let z: Double


    func dot(other: Vector) -> Double {
        return x * other.x + y * other.y + z * other.z
    }

    func cross(other: Vector) -> Vector {
        let x0 = y * other.z - z * other.y
        let y0 = z * other.x - x * other.z
        let z0 = x * other.y - y * other.x
        return Vector(x:  x0, y: y0, z: z0)
    }

    func length() -> Double {
        return sqrt(dot(self))
    }

    func normalize() -> Vector {
        let l = length()
        if l == 0 {
            return Vector(x: 0.0, y: 0.0, z: 0.0)
        }

        return Vector(x: (x / l), y: (y / l), z: (z / l))
    }

    func fuzzyEquals(other: Vector) -> Bool {
        var result = true

        result = result && abs(x - other.x) < 0.001
        result = result && abs(y - other.y) < 0.001
        result = result && abs(z - other.z) < 0.001

        return result
    }

    func reflect(normal: Vector) -> Vector {
        return self - normal * 2 * self.dot(normal)
    }
}

func ==(left: Vector, right: Vector) -> Bool {
    return left.x == right.x &&
           left.y == right.y &&
           left.z == right.z
}

func -(left: Vector, right: Vector) -> Vector {
    return newVector(left: left, right: right) {
        $0 - $1
    }
}

func +(left: Vector, right: Vector) -> Vector {
    return newVector(left: left, right: right) {
        $0 + $1
    }
}

func *(left: Vector, right: Vector) -> Vector {
    return newVector(left: left, right: right) {
        $0 * $1
    }
}

prefix func -(left: Vector) -> Vector {
    return left * -1
}

func *(left: Vector, right: Double) -> Vector {
    return Vector(x: left.x * right, y: left.y * right, z: left.z * right)
}


private func newVector(left left: Vector, right: Vector, closure: (Double, Double) -> Double) -> Vector {
    return Vector(x: closure(left.x, right.x), y: closure(left.y, right.y), z: closure(left.z, right.z))
}

