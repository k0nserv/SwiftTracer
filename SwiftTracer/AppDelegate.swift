//
//  AppDelegate.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var mainController: MainViewController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let contentView = window.contentView {
            let width = Int(contentView.frame.size.width)
            let height = Int(contentView.frame.size.height)
            let camera = Camera(fov: 1.04719755, width: width, height: height)
            mainController = MainViewController(renderer: Renderer(scene: buildScene(), camera: camera, depth: 5))
            window.delegate = mainController

            window.contentView?.addSubview(mainController!.view)
            mainController!.view.frame = contentView.bounds
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    private func buildScene() -> Scene {
        let m1 = Material(color: Color(r: 0.8, g: 0.9, b: 0.9), ambientCoefficient: 0.5, diffuseCoefficient: 0.4, specularCoefficient: 0.1)
        let s1 = Sphere(radius: 2, center: Vector(x: 2.0, y: 0.0, z: 12.0), material: m1)
        let s2 = Sphere(radius: 2, center: Vector(x: -2.0, y: 0.0, z: 15.0), material: m1)


        // rgb(96%, 87%, 62%)
        let m2 = Material(color: Color(r: 1.0, g: 1.0, b: 1.0), ambientCoefficient: 0.6, diffuseCoefficient: 0.6, specularCoefficient: 0.0)
        let m3 = Material(color: Color(r: 1.0, g: 1.0, b: 1.0), ambientCoefficient: m2.ambientCoefficient, diffuseCoefficient: m2.diffuseCoefficient, specularCoefficient: m2.specularCoefficient)
        let p1 = Plane(position: Vector(x: 0.0, y: -5.0, z: 0.0), normal: Vector(x: 0.0, y: 1.0, z: 0.0), material: m2)
        let p2 = Plane(position: Vector(x: 0.0, y: 0.0, z: 100.0), normal: Vector(x: 0.0, y: 0.0, z: -1.0), material: m2)
        let p3 = Plane(position: Vector(x: 20.0, y: 0.0, z: 0.0), normal: Vector(x: -1.0, y: 0.0, z: 0.0), material: m3)

        let light = PointLight(color: Color(r: 1.0, g: 1.0, b: 1.0), position: Vector(x: 5, y: 10, z: 0), intensity: 0.7)

        // rgb(21%, 62%, 97%)
        return Scene(objects: [s1, s2, p1], lights: [light], clearColor: Color(r: 0.21, g: 0.62, b: 0.97))
    }
}


