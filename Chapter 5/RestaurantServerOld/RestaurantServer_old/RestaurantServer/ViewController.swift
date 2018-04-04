//
//  ViewController.swift
//  RestaurantServerApp
//
//  Created by J.A. Korten on 30-03-18.
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
    
    func getTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let str = "\(hour):\(minutes):\(seconds): "
        return str
        
    }
    
    func jsonDict(json: String) -> [String : Any]? {
        if let
            data = json.data(using: String.Encoding.utf8),
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let dict = object as? [String : Any] {
            return dict
        } else {
            return nil
        }
    }
    
    
    
    @IBAction func showCategories(_ sender: NSButton) {
        
        appDelegate.addMessageToConsole("Menu categories: \(appDelegate.restaurant.getCategoryArray() ?? [" not found..."])")
        
        let url = NSURL(string: "http://localhost:\(appDelegate.settings.serverPort)/categories/")!
        NSWorkspace.shared.open(url as URL)
    }
    
    @IBAction func showMenuItems(_ sender: NSButton) {
        appDelegate.addMessageToConsole("Menu items: \(appDelegate.restaurant.getMenuAsString())")
        let url = NSURL(string: "http://localhost:\(appDelegate.settings.serverPort)/menu/")!
        NSWorkspace.shared.open(url as URL)
    }
    
    @IBAction func openMenuItemsJSON(_ sender: Any) {
        
        let documentController = NSDocumentController.shared
        
        let fileManager = FileManager.default
        
        let fileName = "menu" + "." + "json"
        
        let appSupportPath = (fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first)!
        
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: appSupportPath.path)
    
    }
    
    
}

