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
            let position = Vector(x: 0.0, y: 0.0, z: -15.0)
            let direction = Vector(x: 0.0, y: 0.0, z: 1.0)
            let camera = Camera(position: position, direction: direction, fov: 60, width: width, height: height)
            mainController = MainViewController(renderer: Renderer(scene: buildScene(), camera: camera))
            window.delegate = mainController

            window.contentView?.addSubview(mainController!.view)
            mainController!.view.frame = contentView.bounds
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    private func buildScene() -> Scene {
        let m1 = Material(color: Color(r: 0.1, g: 0.5, b: 0.0), ambientCoefficient: 0.5, diffuseCoefficient: 0.6)
        let s1 = Sphere(radius: 2, center: Vector(x: 0.0, y: 0.0, z: 0.0), material: m1)

        let m2 = Material(color: Color(r: 0.5, g: 0.1, b: 0.0), ambientCoefficient: 0.5, diffuseCoefficient: 0.6)
        let s2 = Sphere(radius: 2, center: Vector(x: 5.0, y: 0.0, z: 0.0), material: m2)

        let m3 = Material(color: Color(r: 0.0, g: 0.1, b: 0.5), ambientCoefficient: 0.5, diffuseCoefficient: 0.6)
        let s3 = Sphere(radius: 2, center: Vector(x: -5.0, y: 0.0, z: 0.0), material: m3)
        let light = PointLight(color: Color(r: 0.4, g: 0.4, b: 0.4), position: Vector(x: 0.0, y: 10, z: -5.0), intensity: 0.2)

        return Scene(objects: [s1, s2, s3], lights: [light])
    }
}


