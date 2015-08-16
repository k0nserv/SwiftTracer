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
        let rep = NSBitmapImageRep(focusedViewRect: dirtyRect)

        for var x = 0; x < pixels.count; ++x {
            for var y = 0; y < pixels[x].count; ++y {
                let pixel = pixels[x][y]
                var pixelValues = [Int(pixel.r * 255), Int(pixel.g * 255), Int(pixel.b * 255), 255]
                rep!.setPixel(&pixelValues, atX: x, y: y)
            }
        }

        rep!.drawInRect(dirtyRect)
    }    
}
