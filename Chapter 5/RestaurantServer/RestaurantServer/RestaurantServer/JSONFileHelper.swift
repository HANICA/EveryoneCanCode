//
//  JSONFileHelper.swift
//  RestaurantServer
//
//  Created by J.A. Korten on 03-04-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import Cocoa

let appDelegate = NSApplication.shared.delegate as! AppDelegate

func loadJSONFromBundle() {
    // check if menu.json exists
    loadJSONFromBundle(fileName : "menu", fileExtension : "json")
}

func loadJSONSettingsFromBundle() {
    // check if settings.json exists
    if (loadJSONFromBundle(fileName : "settings", fileExtension : "json")) {
        
    }
}

func loadJSONFromAppPath(fileName : String, fileExtension : String) -> Bool {
    
    let path = Bundle.main.bundleURL.deletingLastPathComponent().path
    let entireFileName = fileName + "." + fileExtension
    let filePath = "\(path)/\(entireFileName)"
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: filePath) {
        addMessageToConsole("File \(entireFileName) found in app directory...")
        checkJSONFile(fileName : "menu", fileExtension: "json")
        return true
    } else {
        addMessageToConsole("Could not find \(entireFileName) in app directory...")
        return false
    }

}

func checkJSONFile(fileName : String, fileExtension : String) {
    
    let entireFileName = fileName + "." + fileExtension
    let path = Bundle.main.bundleURL.deletingLastPathComponent().path
    
    let filePath = "\(path)/\(entireFileName)"
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: filePath) {
        
        if let contents = try? String(contentsOfFile: filePath,
                                      encoding: String.Encoding.utf8
            ) {
            print("Loaded \(contents.count) lines...")
        } else {
            print("Error loading lines...")
            
        }
    }
}

func loadJSONFromBundle(fileName : String, fileExtension : String) -> Bool {
    
    if let filepath = Bundle.main.path(forResource: "\(fileName)", ofType: "\(fileExtension)") {
        let entireFileName = fileName + "." + fileExtension
        do {
            let contents = try String(contentsOfFile: filepath)
            print(contents)
            addMessageToConsole("Default \(entireFileName) was loaded from app bundle")
            
            return processJSON(json : contents, type: fileName)
        } catch {
            // contents could not be loaded
            addMessageToConsole("Could not load \(entireFileName) from app bundle")
            return false
        }
    } else {
        // example.txt not found!
        return false
    }
}

func processJSON(json jsonString : String, type: String) -> Bool {
    
    // Decode data to object
    if let jsonObjects = jsonString.toJSON() {
        var count = 0
        if (type == "settings") {
            let json = parseJsonSettings(anyObj: jsonObjects as AnyObject)
            
            appDelegate.settings = json // assign
        } else if (type == "menu") {
            let json = parseJsonMenu(anyObj: jsonObjects as AnyObject)
            
            appDelegate.restaurant.menu = json
            // assign to restaurant menu
            addMessageToConsole("Successfully parsed JSON: found \(json.count) \(type) items...")
            print(json)

        }

        //print(json.count)
        return true
    } else {
        addMessageToConsole("Parsing JSON failed...")
        return false
    }
    
    
}

func parseJsonSettings(anyObj:AnyObject) -> Settings
{
    var s:Settings = Settings()
    if  anyObj is Array<AnyObject> {
        for json in anyObj as! Array<AnyObject>{
            s.serverPort  =  (json["serverPort"]  as AnyObject? as? UInt16) ?? 8080
        }
    }
    return s
}

func parseJsonMenu(anyObj:AnyObject) -> Array<Menu>{
    
    var list:Array<Menu> = []
    
    if  anyObj is Array<AnyObject> {
        
        var m:Menu = Menu()
        
        for json in anyObj as! Array<AnyObject>{
            m.id  =  (json["id"]  as AnyObject? as? Int) ?? 0
            m.name = (json["name"] as AnyObject? as? String) ?? "" // to get rid of null
            m.description  =  (json["description"]  as AnyObject? as? String) ?? ""
            m.price  =  (json["price"]  as AnyObject? as? Double) ?? 0.0
            m.category  =  (json["category"]  as AnyObject? as? String) ?? ""
            m.imageName  =  (json["imageName"]  as AnyObject? as? String) ?? ""
            
            list.append(m)
        }// for
        
    } // if
    
    return list
    
}

func addMessageToConsole(_ message : String) {
    appDelegate.addMessageToConsole(message)
}
