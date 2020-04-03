//
//  AppDelegate.swift
//  MovToGifConverter
//
//  Created by imurashov private on 02.04.20.
//  Copyright © 2020 imurashov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var isClosed: Bool = false

    @IBOutlet weak var statusMenu: NSMenu!

    let statusItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.variableLength
    )

    @IBAction func onActivateTap(_ sender: Any) {
        let windows = NSApplication.shared.windows
        if let window = windows.first(where: { $0.identifier?.rawValue == "foo" }), isClosed {
            self.isClosed = false
            let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
            window.windowController = storyboard.instantiateController(withIdentifier: "Main") as? NSWindowController
            window.windowController?.showWindow(self)
        }
    }

    @IBAction func onQuitTap(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "Converter"
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

