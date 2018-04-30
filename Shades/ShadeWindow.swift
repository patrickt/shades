//
//  ShadeWindow.swift
//  Shades
//
//  Created by Patrick William Thomson on 4/30/18.
//  Copyright © 2018 Patrick Thomson. All rights reserved.
//

import Cocoa

class ShadeWindow: NSWindow {
    
    let kConfiguringMask : NSWindow.StyleMask = [.closable, .resizable]
    let kStandardMask : NSWindow.StyleMask = .borderless
    
    override var backgroundColor: NSColor! {
        didSet {
            self.alphaValue = self.backgroundColor.alphaComponent
        }
    }
    
    var configuring : Bool = false {
        didSet {
            self.ignoresMouseEvents = !configuring
            self.styleMask = configuring ? kConfiguringMask : kStandardMask
        }
    }
    
    init() {
        super.init(contentRect: NSRect(x: 800, y: 800, width: 400, height: 400),
                   styleMask: kConfiguringMask,
                   backing: NSWindow.BackingStoreType.buffered,
                   defer: false)
        self.backgroundColor = NSColor.blue.withAlphaComponent(0.4)
        self.configuring = true
        self.level = NSWindow.Level.floating
        self.isMovableByWindowBackground = true
    }
    
    func toggleConfiguring() {
        self.configuring = !self.configuring
    }

}
