//
//  ShadeWindow.swift
//  Shades
//
//  Created by Patrick William Thomson on 4/30/18.
//  Copyright © 2018 Patrick Thomson. All rights reserved.
//

import Cocoa

class ShadeWindow: NSWindow {
    
    override var backgroundColor: NSColor! {
        didSet {
            self.alphaValue = self.backgroundColor.alphaComponent
        }
    }
    
    var configuring : Bool = false {
        didSet {
            self.ignoresMouseEvents = !configuring
            if configuring {
                self.styleMask = [NSWindow.StyleMask.closable, NSWindow.StyleMask.resizable]
            } else {
                self.styleMask = NSWindow.StyleMask.borderless
            }
        }
    }
    
    init() {
        super.init(contentRect: NSRect(x: 800, y: 800, width: 400, height: 400),
                   styleMask: NSWindow.StyleMask.borderless,
                   backing: NSWindow.BackingStoreType.buffered,
                   defer: false)
        self.backgroundColor = NSColor.blue.withAlphaComponent(0.4)
        self.configuring = false
        self.level = NSWindow.Level.floating
    }
    
    func toggleConfiguring() {
        self.configuring = !self.configuring
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.setFrameOrigin(NSEvent.mouseLocation)
    }

}
