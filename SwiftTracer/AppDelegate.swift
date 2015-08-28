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
            mainController = MainViewController(renderer: Renderer(scene: buildScene(), camera: camera, maxDepth: 5))
            // This is veeeeery slow
            //            mainController?.renderer?.superSampling = .On(8)
            window.delegate = mainController

            window.contentView?.addSubview(mainController!.view)
            mainController!.view.frame = contentView.bounds
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    private func buildScene() -> Scene {
        let wallMaterial = Material(color: Color(r: 1.0, g: 1.0, b: 1.0),
                        ambientCoefficient: 0.6,
                       diffuseCoefficient: 0.3,
                      specularCoefficient: 0.0,
                    reflectionCoefficient: 0.0,
                    refractionCoefficient: nil)
        let floor = Plane(position: Vector(x: 0.0, y: -1.0, z: 0.0), normal: Vector(x: 0.0, y: 1.0, z: 0.0), material: wallMaterial)
        let frontWall = Plane(position: Vector(x: 0.0, y: 0.0, z: 50.0), normal: Vector(x: 0.0, y: 0.0, z: -1.0), material: wallMaterial)
        let roof = Plane(position: Vector(x: 0.0, y: 15.0, z: 0.0), normal: Vector(x: 0.0, y: -1.0, z: 0.0), material: wallMaterial)

        // rgb(7%, 32%, 57%)
        let leftWallMaterial = Material(color: Color(r: 0.07, g: 0.32, b: 0.57),
                           ambientCoefficient: 0.6,
                           diffuseCoefficient: 0.3,
                          specularCoefficient: 0.0,
                        reflectionCoefficient: 0.0,
                        refractionCoefficient: nil)
        let leftWall = Plane(position: Vector(x: -7.0, y: 0.0, z: 0.0), normal: Vector(x: 1.0, y: 0.0, z: 0.0), material: leftWallMaterial)

        let backWallMaterial = Material(color: Color.Black,
                       ambientCoefficient: 0.0,
                       diffuseCoefficient: 0.0,
                      specularCoefficient: 0.0,
                    reflectionCoefficient: 0.0,
                    refractionCoefficient: nil)
        let backWall = Plane(position: Vector(x: 0.0, y: 0.0, z: -1), normal: Vector(x: 0.0, y: 0.0, z: 1.0), material: backWallMaterial)

        // rgb(57%, 7%, 7%)
        let rightWallMaterial = Material(color: Color(r: 0.7, g: 0.32, b: 0.57),
            ambientCoefficient: 0.6,
            diffuseCoefficient: 0.3,
            specularCoefficient: 0.0,
            reflectionCoefficient: 0.0,
            refractionCoefficient: nil)
        let rightWall = Plane(position: Vector(x: 7.0, y: 0.0, z: 0.0), normal: Vector(x: -1.0, y: 0.0, z: 0.0), material: rightWallMaterial)

        let reflectiveMaterial = Material(color: Color.Black,
                             ambientCoefficient: 0.6,
                             diffuseCoefficient: 0.3,
                            specularCoefficient: 0.4,
                          reflectionCoefficient: 0.6,
                          refractionCoefficient: nil)
        let s1 = Sphere(radius: 0.5, center: Vector(x: -1.5, y: 0.0, z: 10.0), material: reflectiveMaterial)

        let refractiveMaterial = Material(color: Color(r: 1.0, g: 1.0, b: 1.0),
                             ambientCoefficient: 0.0,
                             diffuseCoefficient: 0.4,
                            specularCoefficient: 0.4,
                          reflectionCoefficient: 0.0,
                          refractionCoefficient: 1.5)
        let s2 = Sphere(radius: 0.5, center: Vector(x: -0.6, y: 0.6, z: 8.0), material: refractiveMaterial)

        let greenMaterial = Material(color: Color(r: 0.1, g: 0.74, b: 0.23), ambientCoefficient: 0.5, diffuseCoefficient: 0.3, specularCoefficient: 0.0, reflectionCoefficient: 0.0, refractionCoefficient: nil)
        let s3 = Sphere(radius: 0.5, center: Vector(x: 0.0, y: 1.2, z: 12.0), material: greenMaterial)

        let light = PointLight(color: Color(r: 1.0, g: 1.0, b: 1.0), position: Vector(x: 0, y: 10, z: 8), intensity: 0.6)

        return Scene(objects: [floor, roof, frontWall, leftWall, rightWall, backWall, s1, s2, s3], lights: [light], clearColor: Color.Black)
    }
}


