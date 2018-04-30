//
//  AppDelegate.swift
//  Shades
//
//  Created by Patrick Thomson on 4/30/18.
//  Copyright © 2018 Patrick Thomson. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!

    var statusItem: NSStatusItem!
    var shadeWindows: [ShadeWindow] = []
    var colorPanel: NSColorPanel?
    
    @objc var configuring: Bool = true
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard statusMenu != nil else {
            fatalError("IBOutlets not connected")
        }
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        statusItem.button!.imageScaling = .scaleProportionallyDown
        statusItem.button!.image = NSImage.init(named:NSImage.Name("sunglasses"))
        statusItem.menu = statusMenu

        self.configuring = true
    }
    
    @objc func setShadeColor(_ sender:NSColorPanel) {
        for shade in shadeWindows {
            shade.backgroundColor = sender.color
        }
    }

    @IBAction func addShade(_ sender:NSMenuItem) {
        let newShade = ShadeWindow()
        self.configuring = true
        shadeWindows.append(newShade)
        newShade.makeKeyAndOrderFront(self)
    }
    
    @IBAction func configureShades(_ sender:NSMenuItem) {
        for shade in shadeWindows {
            shade.orderFront(self)
            shade.toggleConfiguring()
        }
    }

    @IBAction func showColorPicker(_ sender:NSMenuItem) {
        if colorPanel == nil {
            colorPanel = NSColorPanel.shared
            colorPanel!.setTarget(self)
            colorPanel!.showsAlpha = true
            colorPanel!.setAction(#selector(AppDelegate.setShadeColor))
            colorPanel!.color = ShadeWindow.defaultColor
        }
        colorPanel!.makeKeyAndOrderFront(self)
    }
}

