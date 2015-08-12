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
            let camera = Camera(fov: 0.785398163, width: width, height: height)
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
        let m1 = Material(color: Color(r: 0.8, g: 0.9, b: 0.9), ambientCoefficient: 1.0, diffuseCoefficient: 0.6)
        let s1 = Sphere(radius: 2, center: Vector(x: 15.0, y: 0.0, z: 15.0), material: m1)

        // rgb(96%, 87%, 62%)
        let m2 = Material(color: Color(r: 0.96, g: 0.87, b: 0.62), ambientCoefficient: 1.0, diffuseCoefficient: 0.2)
        let p1 = Plane(position: Vector(x: 0.0, y: -5.0, z: 0.0), normal: Vector(x: 0.0, y: 1.0, z: 0.0), material: m2)

        let light = PointLight(color: Color(r: 1.0, g: 1.0, b: 1.0), position: Vector(x: 10, y: 10, z: 10), intensity: 0.7)


        // rgb(21%, 62%, 97%)
        return Scene(objects: [s1, p1], lights: [light], clearColor: Color(r: 0.21, g: 0.62, b: 0.97))
    }
}


