//
//  ViewController.swift
//  RestaurantServerApp
//
//  Created by J.A. Korten on 30-03-18.
//

import Cocoa
import SwiftyJSON
import Kitura

class ViewController: NSViewController {
    
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    
    let router = Router()
    let subrouter = Router()
    
    let serverAddress = 8080
    
    @IBOutlet weak var consoleTextView: NSScrollView!
    
    @IBOutlet weak var mainTitleLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.appDelegate.mainVC = self
        self.appDelegate.loadJSONFromBundle() //loadJSON()
        
        startServer()
        //runJSONServer()
        //runCriolloServer()
        let font = NSFont(name: "Consolas", size: 12)
        //self.consoleTextView.documentView!.scrollToEndOfDocument(<#T##sender: Any?##Any?#>)
        
        // tv.documentView!.insertText("\(getTime())\(message)\n")
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    func logToTextView(tv : NSScrollView, message: String) {
        tv.documentView!.insertText("\(getTime())\(message)\n")
        
        //tv.text.append("\(getTime())\(message)\n")
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
    
    func startServer() {
        
        router.get("/world") { request, response, next in
            try response.send("Hello world").end()
        }
        
        /*
        let jsonArray = self.appDelegate._JSONContent?.arrayObject!
        print(self.appDelegate._jsonString)
        */
        router.get("/") {
            request, response, next in
            
            //let json : [Any] = _json
            //jsonString
            
            //try response.status(.OK).send(json: jsonArray!).end()
            //try response.send("Test").end()
            
            next()
        }
        
        router.get("/categories/") {
            request, response, next in
            let cats = self.appDelegate.restaurant.getCategories()
            try response.send(cats).end()
            next()
        }
        
        router.get("/menu/") {
            request, response, next in
            let menu = self.appDelegate.restaurant.getMenuAsString()
            try response.send(menu).end()
            next()
        }
            
            //let json : [Any] = _json
            //jsonString
            
            //let jsonArray = self.appDelegate._JSONContent?.arrayObject!
            
            //let cats = self.appDelegate._JSONContent.
            //let catArray = self.appDelegate._JSONContent![0].arrayValue
            
            
            //try response.status(.OK).send(json: catArray).end()
            //try response.send("Test").end()
            
    
        //}
        
        subrouter.get("/world") { request, response, next in
            try response.send("Hello world").end()
        }
        
        
        //setupRoutes( router, todos: todos )
        
        //router.get("/hello", middleware: subrouter)
        
        
        self.mainTitleLabel.stringValue = "Server is live at http://localhost:\(serverAddress)"

        Kitura.addHTTPServer(onPort: serverAddress, with: router)
        
        DispatchQueue.global().async { Kitura.run() }
        
        /*
         let server = HttpServer()
         server["/"] = { request in
         return .ok(.html("The restaurant is up and running!"))
         }*/
        /*
         server["/hello"] = { .ok(.html("The restaurant is up and running! \($0)"))  }
         */
        /*
         server["/categories"] = { request in
         return .ok(.html("<pre style=\"word-wrap: break-word; white-space: pre-wrap;\">{\n\t\"categories\" : [\n\n\t]\n}</pre>"))
         }
         server["/menu"] = { request in
         return .ok(.html("<pre style=\"word-wrap: break-word; white-space: pre-wrap;\">{\n\t\"items\" : [\n\n\t]\n}</pre>"))
         }
         
         server.notFoundHandler = {
         request in
         return .ok(.html("Cannot GET \(request.path)."))
         }
         
         let serverport = UInt16(8080)
         do {
         try server.start(serverport, forceIPv4: false, priority: DispatchQoS.default.qosClass)
         print("Server started on port \(serverport)...")
         self.mainTitleLabel.stringValue = "Server is live at http://localhost:\(serverport)"
         } catch {
         self.mainTitleLabel.stringValue = "Server could not start."
         print("Server could not start (port \(serverport)...")
         }
         */
        
    }
    
    @IBAction func showCategories(_ sender: NSButton) {
        
        appDelegate.addMessageToConsole("Menu categories: \(appDelegate.restaurant.getCategories() ?? [" not found..."])")
    }
    
    @IBAction func showMenuItems(_ sender: NSButton) {
        appDelegate.addMessageToConsole("Menu items: \(appDelegate.restaurant.getMenuAsString())")
    }
    
    
    
}

