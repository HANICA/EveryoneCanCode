//
//  JSONFileHelper.swift
//  RestaurantServer
//
//  Created by J.A. Korten on 04-04-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import Cocoa

//let appDelegate = NSApplication.shared.delegate as! AppDelegate

func loadJSONFromBundle() {
        
    let (success, content) = checkJSONFile(fileName : "menu", fileExtension : "json")
    //loadJSONFromBundle(fileName : "menu", fileExtension : "json")
    if (success) {
        if (processJSON(json: content, type: "menu")) {
            addMessageToConsole("Successfully loaded menu.json from Application Support folder...")
        } else {
            addMessageToConsole("Could not process menu.json...")
        }
    } else {
        addMessageToConsole("Could not load menu.json from Application Support folder...")
    }
}

func loadJSONSettingsFromBundle() {
    // check if settings.json exists
    if (loadJSONFromBundle(fileName : "settings", fileExtension : "json")) {
        // could not load settings from bundle...
    }
}

func loadJSONFromAppPath(fileName : String, fileExtension : String) -> Bool {
    
    // This function won't work since we have Sandboxed the app.
    
    let path = Bundle.main.bundleURL.deletingLastPathComponent().path
    let entireFileName = fileName + "." + fileExtension
    let filePath = "\(path)/\(entireFileName)"
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: filePath) {
        addMessageToConsole("File \(entireFileName) found in app folder...")
        let (status, content) = checkJSONFile(fileName : "menu", fileExtension: "json")
        if (status) {
            return processJSON(json: content, type: "menu")
        } else {
            return false
        }
        
    } else {
        addMessageToConsole("Could not find \(entireFileName) in app folder...")
        return false
        
    }
    
}

func checkImagesFolder() -> Bool {
    
    // we check if images folder exists in Application Support
    // if so the server can load images from there!
    
    let fileManager = FileManager.default
    
    var appSupportPath = (fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first)!
    
    let subFolder = "images/"
    appSupportPath.appendPathComponent(subFolder)

    if fileManager.fileExists(atPath: appSupportPath.path) {
        addMessageToConsole("Folder '\(subFolder)' found in App Support path...")
        // Add this folder to the server...
        // This will be done in ServerHelper
        return true
    } else {
        
        addMessageToConsole("Could not find '\(subFolder)' in App Support path so defaulting to images in App Bundle.")
        return false
        
    }
}

func checkJSONFile(fileName : String, fileExtension : String) -> (Bool, String) {

    // This function will:
    // 1. try to find menu.json in the Application Support folder
    // 2. if this does not work: it will try to find the menu.json in the app bundle and copy it to the Application Support folder
    // 3. it will try to load the JSON and return true and the content
    // 4. if everything fails it will return false and nothing
    
    let fileManager = FileManager.default
    
    let entireFileName = fileName + "." + fileExtension
    
    let appSupportPath = (fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first)!
    
    do {
        let applicationSupportDirectory = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let demoPlistURL = applicationSupportDirectory.appendingPathComponent(entireFileName)
        if (!fileManager.fileExists(atPath: demoPlistURL.path)) {
            
            if let filepath = Bundle.main.path(forResource: "\(fileName)", ofType: "\(fileExtension)") {
                do {
                    try fileManager.copyItem(atPath: filepath, toPath: demoPlistURL.path)
                    print("Copied json from bundle to application support folder...")
                } catch {
                    return (false, "")
                }
                
            }
            
        } else {
            print("Will load from application folder...")
        }
        print(demoPlistURL)
        
        if let contents = try? String(contentsOfFile: demoPlistURL.path,
                                      encoding: String.Encoding.utf8
            ) {
            print("Loaded \(contents.count) lines...")
            return (true, contents)
        } else {
            print("Could not load lines from file...")
            return (false, "")
            
        }
    } catch {
        print(error)
    }
    
    let filePath = "\(appSupportPath)\(entireFileName)"
    
    if fileManager.fileExists(atPath: filePath) {
        
        if let contents = try? String(contentsOfFile: filePath,
                                      encoding: String.Encoding.utf8
            ) {
            print("Loaded \(contents.count) lines...")
            return (true, contents)
        } else {
            print("Could not load lines from file...")
            return (false, "")
            
        }
    }
    return (false, "")
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
        return false
    }
}

func processJSON(json jsonString : String, type: String) -> Bool {
    
    // Decode data to object
    if let jsonObjects = jsonString.toJSON() {

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
            s.showHostname    = (json["showHostname"] as AnyObject? as? Int == 1) 
            s.homeHTML    = (json["rootHTML"] as AnyObject? as? String) ?? "RestaurantServer is running"
        }
    }
    return s
}

func parseJsonMenu(anyObj:AnyObject) -> Array<Menu>{
    // maps the menu.json data to our Restaurant + Menu object structure
    
    var list:Array<Menu> = []
    
    if  anyObj is Array<AnyObject> {
        
        var m:Menu = Menu()
        
        for json in anyObj as! Array<AnyObject>{
            m.id  =  (json["id"]  as AnyObject? as? Int) ?? 0
            m.name = (json["name"] as AnyObject? as? String) ?? "" // to get rid of null
            m.description  =  (json["description"]  as AnyObject? as? String) ?? ""
            m.price  =  (json["price"]  as AnyObject? as? Double) ?? 0.0
            m.category  =  (json["category"]  as AnyObject? as? String) ?? ""
            m.image_url  =  (json["image_url"]  as AnyObject? as? String) ?? ""
            
            list.append(m)
        }
    }
    
    return list
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

func addMessageToConsole(_ message : String) {
    appDelegate.addMessageToConsole(message)
}
