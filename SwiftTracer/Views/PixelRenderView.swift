//
//  PixelRenderView.swift
//  SwiftTracer
//
//  Created by Hugo Tunius on 09/08/15.
//  Copyright © 2015 Hugo Tunius. All rights reserved.
//

import Cocoa
import GLKit

class PixelRenderView: NSView {
    var pixels: [[Color]] = []
class PixelRenderView: NSOpenGLView {
    var textureID: GLuint = 0
    var pixels: [[Color]] = [] {
        didSet {
            var result: [Double] = []
            for var x = 0; x < pixels.count; x++ {
                for var y = 0; y < pixels[x].count; y++ {
                    let color = pixels[x][y]

                    result.append(color.r)
                    result.append(color.g)
                    result.append(color.b)
                }
            }
            glTexImage2D(UInt32(GL_TEXTURE_2D), GLint(0), GLint(GL_RGB), GLsizei(pixels.count), GLsizei(pixels[0].count), GLint(0), UInt32(GL_RGB), UInt32(GL_DOUBLE), &result)
        }
    }

    override func prepareOpenGL() {
        super.prepareOpenGL()
        glClearColor(0.0, 0.0, 0.0, 1.0)
        glGenTextures(1, &textureID)

        glBindTexture(UInt32(GL_TEXTURE_2D), textureID)
        glTexParameteri(UInt32(GL_TEXTURE_2D), UInt32(GL_TEXTURE_WRAP_S), GL_CLAMP_TO_BORDER)
        glTexParameteri(UInt32(GL_TEXTURE_2D), UInt32(GL_TEXTURE_WRAP_T), GL_CLAMP_TO_BORDER)
            }
        }
    }

        rep!.drawInRect(dirtyRect)
    }    
}
