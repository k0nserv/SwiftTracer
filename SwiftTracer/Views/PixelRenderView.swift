//
//  PixelRenderView.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Cocoa
import SwiftTracer_Core

protocol PixelRenderViewDelegate: class {
    func rightMouseClickedAt(x x: CGFloat, y: CGFloat, event: NSEvent)
}

class PixelRenderView: NSView {
    var pixels: [Color] = [] {
        didSet {
            rawPixels = UnsafeMutablePointer<UInt8>(pixels)
        }
    }
    weak var delegate: PixelRenderViewDelegate?
    private var rawPixels: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>()

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        if pixels.count == 0 {
            return
        }

        let rep = NSBitmapImageRep(bitmapDataPlanes: &rawPixels,
                                         pixelsWide: Int(bounds.size.width),
                                         pixelsHigh: Int(bounds.size.height),
                                      bitsPerSample: 8,
                                    samplesPerPixel: 4,
                                           hasAlpha: true,
                                           isPlanar: false,
                                     colorSpaceName: NSDeviceRGBColorSpace,
                                        bytesPerRow: Int(bounds.size.width) * 4,
                                       bitsPerPixel: 32)
        guard let r = rep else {
            return
        }

        r.drawInRect(dirtyRect)
    }

    override func rightMouseUp(theEvent: NSEvent) {
        guard let d = delegate else {
            return
        }

        let location = theEvent.locationInWindow
        let center = convertPoint(location, fromView: nil)

        d.rightMouseClickedAt(x: center.x, y: center.y, event: theEvent)
    }
}
