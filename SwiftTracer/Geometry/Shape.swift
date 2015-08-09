//
//  Shape.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation


protocol Shape {
    var material: Material { get }
    func intersectWithRay(ray: Ray) -> Intersection?
}