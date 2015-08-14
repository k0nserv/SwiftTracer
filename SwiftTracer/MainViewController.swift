//
//  MainViewController.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    var renderer: Renderer?
    var pixelView: PixelRenderView?

    init?(renderer: Renderer) {
        self.renderer = renderer
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.renderer = nil
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        renderer!.delegate = self
        renderer!.render()
        // Do view setup here.
    }

    override func viewDidLayout() {
        super.viewDidLayout()
        print("Helllo new layout")
    }

    override func loadView() {
        pixelView = PixelRenderView()
        view = pixelView!
    }
}

extension MainViewController : NSWindowDelegate {
    func windowDidResize(notification: NSNotification) {
        view.frame = (view.window?.contentView?.bounds)!

        if var r = renderer {
            r.camera = r.camera.cameraWithNewResolution(newWidth: Int(self.view.frame.width), newHeight: Int(self.view.frame.height))
            r.abortRendering()
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                r.render()
            }
        }
    }
}

extension MainViewController : RendererDelegate {
    func didFinishRendering(pixels: [[Color]]) {
        dispatch_async(dispatch_get_main_queue()) {
            if let pv = self.pixelView {
                pv.pixels = pixels
                pv.setNeedsDisplayInRect(pv.bounds)
            }
        }
    }
}
