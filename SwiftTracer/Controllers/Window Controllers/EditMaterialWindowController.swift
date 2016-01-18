//
//  EditMaterialWindowController.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 31/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Cocoa

protocol EditMaterialWindowControllerDelegate: class {
    func editWindowWillClose()
    func renderSceneRequest()
}


private enum SliderTags: Int {
    case Ambient = 500
    case Diffuse = 501
    case Specular = 502
    case Reflective = 503
}

class EditMaterialWindowController: NSWindowController {
    weak var delegate: EditMaterialWindowControllerDelegate? = nil
    var material: Material!
    @IBOutlet weak var colorWell: NSColorWell!
    @IBOutlet weak var ambientSlider: NSSlider!
    @IBOutlet weak var diffuseSlider: NSSlider!
    @IBOutlet weak var specularSlider: NSSlider!
    @IBOutlet weak var reflectiveSlider: NSSlider!

    override init(window: NSWindow!) {
        super.init(window: window)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(material: Material) {
        self.init(windowNibName: "SwiftTracer.EditMaterialWindowController")
        self.material = material
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.title = "Material properties"
        window?.delegate = self

        colorWell.color = NSColor(calibratedRed: CGFloat(material.color.rd), green: CGFloat(material.color.gd), blue: CGFloat(material.color.gd), alpha: 1.0)
        ambientSlider.doubleValue = material.ambientCoefficient
        diffuseSlider.doubleValue = material.diffuseCoefficient
        specularSlider.doubleValue = material.specularCoefficient
        reflectiveSlider.doubleValue = material.reflectionCoefficient
    }

    @IBAction func didChangeColor(sender: AnyObject) {
        let c = sender as! NSColorWell
        let color = c.color
        material.color = Color(r: Double(color.redComponent), g: Double(color.greenComponent), b: Double(color.blueComponent))
    }

    @IBAction func sliderDidChangeValue(sender: AnyObject) {
        let s = sender as! NSSlider

        switch s.tag {
        case SliderTags.Ambient.rawValue:
            material.ambientCoefficient = s.doubleValue
        case SliderTags.Diffuse.rawValue:
            material.diffuseCoefficient = s.doubleValue
        case SliderTags.Specular.rawValue:
            material.specularCoefficient = s.doubleValue
        case SliderTags.Reflective.rawValue:
            material.reflectionCoefficient = s.doubleValue
        default: break
        }
    }
    @IBAction func didTapRenderScene(sender: AnyObject) {
        guard let d = delegate else {
            return
        }

        d.renderSceneRequest()
    }
}

extension EditMaterialWindowController: NSWindowDelegate {
    func windowWillClose(notification: NSNotification) {
        guard let d = delegate else {
            return
        }

        d.editWindowWillClose()
    }
}
