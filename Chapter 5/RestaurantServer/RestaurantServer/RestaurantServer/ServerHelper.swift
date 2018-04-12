//
//  ServerHelper.swift
//  RestaurantServer
//
//  Created by J.A. Korten on 04-04-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import Foundation
import Telegraph

// appDelegate can be reused.

func showMenu(request: HTTPRequest) -> HTTPResponse {
    print(request)
    var menu = ""
    if let _uri = request.uri.query {
        
        if (_uri.contains("category=")) {
            // request with category selection
            let categories = _uri.split(separator: "=")
            let selector = String(categories[1])
            print(selector)
            menu = appDelegate.restaurant.getCategories(category : selector)
        }
    } else {
        menu = appDelegate.restaurant.getMenuAsString()
    }
    return HTTPResponse(content: menu)
        
}

func showCategories(request: HTTPRequest) -> HTTPResponse {
    let categories = appDelegate.restaurant.getCategoriesAsString()
    return HTTPResponse(content: categories)
}

func returnCategory(request: HTTPRequest) -> HTTPResponse {
    let name = request.params["category"] ?? "{}"
    let category = appDelegate.restaurant.getCategories(category : name)
    // get only menuitems from category in name
    return HTTPResponse(content: category)
}

func processOrder(request : HTTPRequest) -> HTTPResponse {
    print("Process order:")
    print("Request: \(request)")
    let jsonEncoder = JSONEncoder()
    if let string = String(data: request.body, encoding: .utf8) {
        print("Body: \(string)")
        let order = Order(menuIds: [])
        let time = order.decodeOrder(data: request.body)
        let preTime = PreparationTime(prepTime: time)
        let jsonData = try? jsonEncoder.encode(preTime)
        if let jsonDataString = String(data: jsonData!, encoding: String.Encoding.utf8) {
            return HTTPResponse(content: jsonDataString)
        }
    } else {
        print("Body does not contain a valid UTF-8 sequence")
    }
    return HTTPResponse(content: "OK")
}

func showMainPage() -> String {
    let html = appDelegate.settings.homeHTML
    return html
}

func showHostname() {
    if appDelegate.settings.showHostname {
        if let deviceName = Host.current().name {
            addMessageToConsole("Note: server is also available using hostname: http://\(deviceName):\(appDelegate.settings.serverPort)/")
        }
    }
}

func handleGreeting(request: HTTPRequest) -> HTTPResponse {
    let name = request.params["name"] ?? "stranger"
    return HTTPResponse(content: "Hello \(name.capitalized)")
}

func handleImage(request: HTTPRequest) -> HTTPResponse {
    let name = request.params["name"] ?? "na"
    // try to find image in bundle
    print("Hi");
    
    // else try to find image in app folder
    
    return HTTPResponse(content: "Hello \(name.capitalized)")
}

extension Server {
    func addRoutes() {
        self.route(.get, "menu", showMenu)
        self.route(.get, "menu/", showMenu)
        self.route(.get, "categories", showCategories)
        self.route(.get, "categories/", showCategories)
        self.route(.post, "order", processOrder)
        self.route(.post, "order/", processOrder)
        self.serveBundle(.main, "images/")
        self.route(.get, "/") { (.ok, showMainPage()) }
    }
}

