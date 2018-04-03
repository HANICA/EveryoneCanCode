//
//  AppDelegate.swift
//  RestaurantServerApp
//
//  Created by J.A. Korten on 30-03-18.
//

import Cocoa
import Telegraph

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainVC : NSViewController?
    
    let serverHTTP = Server()
    let serverPort : UInt16 = 8080
    
    
    //var _JSONContent : JSON?
    var _jsonString : String?
    
    var restaurant = Restaurant()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func loadJSONFromBundle() {
        if let filepath = Bundle.main.path(forResource: "menu", ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
                addMessageToConsole("Default menu.json was loaded from app bundle")
                processJSON(json : contents)
            } catch {
                // contents could not be loaded
                addMessageToConsole("Could not load menu.json from app bundle")            }
        } else {
            // example.txt not found!
        }
    }
    
    func loadJSON() {
        // check if menu.json exists
        
        let path = Bundle.main.bundleURL.deletingLastPathComponent().path
        
        print(path)
        let filePath = "\(path)/menu.json"
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            addMessageToConsole("File menu.json found in app directory...")
            checkJSONFile(jsonfile : filePath)
        } else {
            addMessageToConsole("Could not find menu.json in app directory...")
        }
    }
    
    func checkJSONFile(jsonfile : String) {
        //print(jsonfile)
        
        let path = Bundle.main.bundleURL.deletingLastPathComponent().path
        
        let filePath = "\(path)/menu.json"
        
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

    
    func addMessageToConsole(_ message : String) {
        let vc = self.mainVC as! ViewController
        vc.logToTextView(message: message)
    }
    
    func processJSON(json jsonString : String) {
        
        // Decode data to object
        if let jsonObjects = jsonString.toJSON() {
            
            let json = parseJson(anyObj: jsonObjects as AnyObject)
            
            restaurant.menu = json // assign to restaurant menu
            addMessageToConsole("Successfully parsed JSON...")
            addMessageToConsole("Found \(json.count) menu items...")
            print(json)
            //print(json.count)
            
        } else {
            addMessageToConsole("Parsing JSON failed...")
            
            /*
             let jsonDecoder = JSONDecoder()
             let menu = try jsonDecoder.decode(Menu.self, from: jsonString.toJSON() as! Data)
             print("Name : \(menu.name)")
             print("Description : \(menu.description)")
             */
        }
        
        
    }
    
    func parseJson(anyObj:AnyObject) -> Array<Menu>{
        
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
    
    func startServer() {
        do {
            try serverHTTP.start(onPort: serverPort)
            
            serverHTTP.route(.get, "menu/", showMenu)
            serverHTTP.route(.get, "categories/", showCategories)
            serverHTTP.route(.get, "/") { (.ok, "Server is running") }
        } catch {
            addMessageToConsole("Could not start server...")
        }

    }
    
    func showMenu(request: HTTPRequest) -> HTTPResponse {
        let menu = self.restaurant.getMenuAsString()
        return HTTPResponse(content: menu)
    }
    
    func showCategories(request: HTTPRequest) -> HTTPResponse {
        let categories = self.restaurant.getCategoriesAsString()
        return HTTPResponse(content: categories)
    }
    
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
