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
            let position = Vector(x: 0.0, y: 0.0, z: -10.0)
            let direction = Vector(x: 0.0, y: 0.0, z: 1.0)
            let camera = Camera(position: position, direction: direction, fov: 45, width: width, height: height)
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
        let material = Material(color: Color(r: 0.1, g: 0.5, b: 0.0))
        let sphere = Sphere(radius: 2, center: Vector(x: 0.0, y: 0.0, z: 0.0), material: material)

        return Scene(objects: [sphere])
    }
}


