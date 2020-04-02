//
//  DestinationView.swift
//  MovToGifConverter
//
//  Created by imurashov private on 02.04.20.
//  Copyright © 2020 imurashov. All rights reserved.
//

import Cocoa

class DestinationView: NSView {

    func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
        var canAccept = false
        let pasteBoard = draggingInfo.draggingPasteboard
        
        if pasteBoard.canReadObject(
            forClasses: [NSURL.self],
            options: [NSPasteboard.ReadingOptionKey.urlReadingFileURLsOnly:true]
        ) {
            canAccept = true
        }
        
        return canAccept
    }
      
}
