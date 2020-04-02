//
//  ViewController.swift
//  MovToGifConverter
//
//  Created by imurashov private on 02.04.20.
//  Copyright © 2020 imurashov. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSDraggingDestination {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let destinationView = self.view as? DestinationView {
            destinationView.registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
