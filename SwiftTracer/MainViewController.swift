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
        render()
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

    private func render() {
        if let pv = pixelView {
            if nil != renderer {
                pv.pixels = renderer!.render()
            }
        }
    }
}

extension MainViewController : NSWindowDelegate {
    func windowDidResize(notification: NSNotification) {
        view.frame = (view.window?.contentView?.bounds)!

        if nil != renderer {
            renderer!.camera = renderer!.camera.cameraWithNewResolution(newWidth: Int(view.frame.width), newHeight: Int(view.frame.height))
            render()
        }
    }
}
