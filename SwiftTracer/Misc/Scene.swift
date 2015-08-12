//
//  Scene.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation


struct Scene {
    let objects: [Shape]
    let lights: [PointLight]
    let clearColor: Color
}
