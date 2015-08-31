//
//  MainViewController.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    var materialEditWindow: NSWindowController?
    var renderer: Renderer?
    @IBOutlet weak var pixelView: PixelRenderView!
    @IBOutlet weak var activityIndicator: NSProgressIndicator!

    init?(renderer: Renderer) {
        self.renderer = renderer
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pixelView.delegate = self
        renderer!.delegate = self
        renderer!.render()
        activityIndicator.startAnimation(nil)
        // Do view setup here.
    }

    private func startRendering() {
        pixelView.hidden = true
        activityIndicator.hidden = false
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            self.renderer!.render()
        }
    }
}

extension MainViewController : NSWindowDelegate {
    func windowDidResize(notification: NSNotification) {
        view.frame = (view.window?.contentView?.bounds)!
        pixelView!.frame = view.bounds

        renderer!.camera = renderer!.camera.cameraWithNewResolution(newWidth: Int(self.view.frame.width), newHeight: Int(self.view.frame.height))
        renderer!.abortRendering()
        startRendering()
    }
}

extension MainViewController : RendererDelegate {
    func didFinishRendering(pixels: [Color], duration: NSTimeInterval) {
        NSLog("Rendering took \(duration) seconds")
        dispatch_async(dispatch_get_main_queue()) {
            if let pv = self.pixelView {
                pv.pixels = pixels
                pv.setNeedsDisplayInRect(pv.bounds)
                self.activityIndicator.hidden = true
                self.pixelView.hidden = false
            }
        }
    }
}

extension MainViewController : PixelRenderViewDelegate {
    func rightMouseClickedAt(x x: CGFloat, y: CGFloat, event: NSEvent) {
        guard let r = renderer else {
            return
        }

        let ray = r.camera.createRay(x: Int(x), y: Int(y))
        let hit = r.scene.intersect(ray)

        guard let h = hit else {
            return
        }

        let menu = NSMenu(title: "")
        let item = NSMenuItem(title: "Edit Material", action: Selector("editMaterial:"), keyEquivalent: "")
        item.representedObject = h as AnyObject
        item.target = self
        menu.addItem(item)

        NSMenu.popUpContextMenu(menu, withEvent: event, forView: pixelView)
    }

    internal func editMaterial(sender: NSMenuItem) {
        guard let intersection = sender.representedObject as! Intersection? else {
            assert(false, "editMaterial: expects sender.representedObject to be of type Intersection")
            return
        }

        materialEditWindow = NSWindowController(windowNibName: "EditMaterialWindow")
        materialEditWindow!.showWindow(self)
        view.window?.makeKeyAndOrderFront(materialEditWindow!.window)
        materialEditWindow!.window?.makeKeyWindow()
    }
}
