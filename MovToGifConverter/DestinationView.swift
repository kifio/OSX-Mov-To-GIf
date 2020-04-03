//
//  DestinationView.swift
//  MovToGifConverter
//
//  Created by imurashov private on 02.04.20.
//  Copyright © 2020 imurashov. All rights reserved.
//

import Cocoa

protocol DraggingItemsHandler {
    func handle(url: String)
}

class DestinationView: NSView {
    
    private let options = [NSPasteboard.ReadingOptionKey.urlReadingFileURLsOnly:true]
    
    var itemsHandler: DraggingItemsHandler? = nil
    
    var isReceivingDrag = false {
        didSet {
            needsDisplay = true
        }
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = shouldAllowDrag(sender)
        isReceivingDrag = allow
        return allow ? .copy : NSDragOperation()
    }

    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.isReceivingDrag = false
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let allow = shouldAllowDrag(sender)
        return allow
    }
    
    func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
        var canAccept = false
        let pasteBoard = draggingInfo.draggingPasteboard
        if pasteBoard.canReadObject(
            forClasses: [NSURL.self],
            options: self.options
        ) {
            canAccept = true
        }
        return canAccept
    }
    
    override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
        self.isReceivingDrag = false
        let pasteBoard = draggingInfo.draggingPasteboard
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: self.options) as? [URL],
            urls.count > 0 {
            urls.forEach {
                itemsHandler?.handle(url: $0.path)
            }
            return true
        }
        return false
    }

    override func draw(_ dirtyRect: NSRect) {
        if isReceivingDrag {
            NSColor.selectedControlColor.set()
        } else {
            NSColor.clear.set()
        }
        NSBezierPath(rect:bounds).fill()
    }
}
