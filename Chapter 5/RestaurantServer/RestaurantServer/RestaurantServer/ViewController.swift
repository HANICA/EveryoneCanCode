//
//  ViewController.swift
//  RestaurantServer
//
//  Created by J.A. Korten on 04-04-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var consoleTextView: NSScrollView!
    
    @IBOutlet weak var mainTitleLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate.mainVC = self
        self.appDelegate.loadData()
        self.appDelegate.startServer()
        
        self.mainTitleLabel.stringValue = "Server is live at http://localhost:\(self.appDelegate.settings.serverPort)"
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    func logToTextView(tv : NSScrollView, message: String) {
        tv.documentView!.insertText("\(getTime())\(message)\n")
    }
    
    func logToTextView(message: String) {
        logToTextView(tv: consoleTextView, message: message)
    }
    
    
    
    
    
    @IBAction func showCategories(_ sender: NSButton) {
        appDelegate.reloadData()
        appDelegate.addMessageToConsole("Menu categories: \(appDelegate.restaurant.getCategoryArray() ?? [" not found..."])")
        
        let url = NSURL(string: "http://localhost:\(appDelegate.settings.serverPort)/categories/")!
        NSWorkspace.shared.open(url as URL)
    }
    
    @IBAction func showMenuItems(_ sender: NSButton) {
        appDelegate.reloadData()
        appDelegate.addMessageToConsole("Menu items: \(appDelegate.restaurant.getMenuAsString())")
        let url = NSURL(string: "http://localhost:\(appDelegate.settings.serverPort)/menu/")!
        NSWorkspace.shared.open(url as URL)
    }
    
    @IBAction func openMenuItemsJSON(_ sender: Any) {
        
        let fileManager = FileManager.default
        let appSupportPath = (fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first)!
        
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: appSupportPath.path)
        
    }
    

}

