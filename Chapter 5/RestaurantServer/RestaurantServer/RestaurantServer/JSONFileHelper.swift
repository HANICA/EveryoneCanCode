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
    if (loadJSONFromAppPath(fileName : "menu", fileExtension : "json")) {
        //
    } else {
        loadJSONFromBundle(fileName : "menu", fileExtension : "json")
    }
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
        let (status, content) = checkJSONFile(fileName : "menu", fileExtension: "json")
        if (status) {
            return processJSON(json: content, type: "menu")
        } else {
            return false
        }
        
    } else {
        addMessageToConsole("Could not find \(entireFileName) in app directory...")
        return false
        
    }

}

func checkJSONFile(fileName : String, fileExtension : String) -> (Bool, String) {
    
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
    
    //let path = Bundle.main.bundleURL.deletingLastPathComponent().path
    
    let filePath = "\(appSupportPath)\(entireFileName)"
    
    if fileManager.fileExists(atPath: filePath) {
        
        //let location = NSString(string: "~/\(filePath)").expandingTildeInPath
        //let fileContent = try? NSString(contentsOfFile: location, encoding: String.Encoding.utf8.rawValue)
        //print(fileContent)
        
    //print(FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first)
        

        
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
        // example.txt not found!
        return false
    }
}

func processJSON(json jsonString : String, type: String) -> Bool {
    
    // Decode data to object
    if let jsonObjects = jsonString.toJSON() {
        //var count = 0
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
