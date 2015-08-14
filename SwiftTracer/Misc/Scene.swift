//
//  Scene.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Foundation


class Scene {
    let objects: [Shape]
    let lights: [PointLight]
    let clearColor: Color

    init(objects: [Shape], lights: [PointLight], clearColor: Color) {
        self.objects = objects
        self.lights = lights
        self.clearColor = clearColor
    }
}
