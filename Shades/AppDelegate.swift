//
//  AppDelegate.swift
//  Shades
//
//  Created by Patrick William Thomson on 4/30/18.
//  Copyright © 2018 Patrick Thomson. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!

    var statusItem: NSStatusItem!
    var shadeWindows: [ShadeWindow] = []
    var colorPanel: NSColorPanel = NSColorPanel.shared
    
    @objc var configuring: Bool = false
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard (statusMenu != nil) else {
            fatalError("IBOutlets not connected")
        }
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button!.title = "Shades"
        statusItem.menu = statusMenu
        
        colorPanel.setTarget(self)
        colorPanel.showsAlpha = true
        colorPanel.setAction(#selector(AppDelegate.setShadeColor))
    }
    
    @objc func setShadeColor(_ sender:NSColorPanel) {
        for shade in shadeWindows {
            shade.backgroundColor = sender.color
        }
    }

    @IBAction func addShade(_ sender:NSMenuItem) {
        self.configuring = true
        let newShade = ShadeWindow()
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
        colorPanel.makeKeyAndOrderFront(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

