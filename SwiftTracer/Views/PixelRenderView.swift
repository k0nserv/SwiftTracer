//
//  PixelRenderView.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Cocoa

class PixelRenderView: NSView {
    var pixels: [Color] = [] {
        didSet {
            rawPixels = UnsafeMutablePointer<UInt8>.alloc(pixels.count * 4)

            var index = 0
            pixels.forEach {
                rawPixels[index] = $0.r
                rawPixels[index + 1] = $0.g
                rawPixels[index + 2] = $0.b
                rawPixels[index + 3] = 255
                index += 4
            }
        }
    }
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
}
