//
//  PixelRenderView.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Cocoa

class PixelRenderView: NSView {
    var pixels: [[Color]] = []

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        if pixels.count == 0 || pixels[0].count == 0 {
            return
        }

        let width = pixels.count
        let height = pixels[0].count

        let rep = NSBitmapImageRep(bitmapDataPlanes: nil,
                                         pixelsWide: width,
                                         pixelsHigh: height,
                                      bitsPerSample: 8,
                                    samplesPerPixel: 3,
                                           hasAlpha: false,
                                           isPlanar: false,
                                     colorSpaceName: NSDeviceRGBColorSpace,
                                        bytesPerRow: width * 3,
                                       bitsPerPixel: 24)
        guard let r = rep else {
            return
        }

        let pixelData = r.bitmapData
        NSLog("Width: \(width)")
        NSLog("Height: \(height)")
        NSLog("Bytes per row \(r.bytesPerRow)")

        for var y = 0; y < height; ++y {
            for var x = 0; x < width; ++x {
                let pixel = pixels[x][y]
                let index = y * r.bytesPerRow + x * 3
                pixelData[index + 0] = UInt8(pixel.r * 255)
                pixelData[index + 1] = UInt8(pixel.g * 255)
                pixelData[index + 2] = UInt8(pixel.b * 255)
            }
        }



        r.drawInRect(dirtyRect)
    }    
}
