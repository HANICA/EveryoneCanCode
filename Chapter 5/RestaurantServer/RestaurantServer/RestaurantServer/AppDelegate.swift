//
//  AppDelegate.swift
//  RestaurantServer
//
//  Created by J.A. Korten on 04-04-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import Cocoa
// import Telegraph

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainVC : NSViewController?
    
    let serverHTTP = Server()
    
    var _jsonString : String?
    
    var restaurant = Restaurant()
    var settings   = Settings()
    
    var imageFolderFound = false
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
    }
    
    func loadData() {
        self.imageFolderFound = checkImagesFolder()
        loadJSONSettingsFromBundle()
        reloadData()
    }
    
    func reloadData() -> (Bool, String) {
        // will load or reload the menu data)
        loadJSONFromBundle()
        return checkJSONFile(fileName: "menu", fileExtension: "json")
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func addMessageToConsole(_ message : String) {
        let vc = self.mainVC as! ViewController
        vc.logToTextView(message: message)
    }
    
    func startServer() {
        do {
            
            try serverHTTP.start(onPort: self.settings.serverPort)
            
            serverHTTP.addRoutes()
            
            showHostname()
            
        } catch {
            addMessageToConsole("Could not start server...")
        }
        
    }
    
    
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
