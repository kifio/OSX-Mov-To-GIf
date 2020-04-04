//
//  ViewController.swift
//  MovToGifConverter
//
//  Created by imurashov private on 02.04.20.
//  Copyright © 2020 imurashov. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!

    private let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let destinationView = self.view as? DestinationView {
            destinationView.registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
            destinationView.itemsHandler = self
        }
    }

    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
}

extension ViewController : DraggingItemsHandler {
    
    func handle(url: String) {
        label.isHidden = true
        progressIndicator.isHidden = false
        DispatchQueue.global(qos: .utility).async {
            let filename = self.formatter.string(from: Date())
            let home = FileManager.default.homeDirectoryForCurrentUser.path
            let status = self.runCommand(
                cmd: "/usr/local/bin/ffmpeg",
                args: "-i", url, "-pix_fmt", "rgb24", "-filter_complex", "scale=480:-1", "\(home)/Desktop/\(filename).gif"
            )

            print("Programm exit with status \(status)")
            DispatchQueue.main.async {
                self.label.isHidden = false
                self.progressIndicator.isHidden = true
            }
        }
    }
    
    func runCommand(cmd : String, args : String...) -> Int32 {
        let task = Process()
        task.launchPath = cmd
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
}

extension ViewController : NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        (NSApplication.shared.delegate as? AppDelegate)?.isClosed = true
    }
}
