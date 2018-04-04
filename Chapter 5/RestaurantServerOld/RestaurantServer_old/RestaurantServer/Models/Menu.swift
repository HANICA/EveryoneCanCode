//
//  Menu.swift
//  RestaurantServerApp
//
//  Created by J.A. Korten on 02-04-18.
//

import Foundation

struct Menu: Codable {
    var id : Int = 0
    var name : String = ""
    var description : String = ""
    var price : Double = 0.0
    var category : String = ""
    var imageName : String = ""
    
    func printMenuItem() -> String {
        var result = ""
        result += formatItem(itemkey : "id", item : id, last : false)
        result += formatItem(itemkey : "name", item : name, last : false)
        result += formatItem(itemkey : "description", item : description, last : false)
        result += formatItem(itemkey : "price", item : price, last : false)
        result += formatItem(itemkey : "category", item : category, last : false)
        result += formatItem(itemkey : "imageName", item : imageName, last : true)

        //result = "{\n" + result + "\n}"
        return result
    }
    
    func formatItem(itemkey : String, item : Int, last : Bool) -> String {
        return addSpace() + "\"\(itemkey)\" : \(item)" + addComma(last : last)
    }
    
    func formatItem(itemkey : String, item : Double, last : Bool) -> String {
        return addSpace() + "\"\(itemkey)\" : \(item)" + addComma(last : last)
    }
    
    func formatItem(itemkey : String, item : String, last : Bool) -> String {
        return addSpace() + "\"\(itemkey)\" : \"\(item)\"" + addComma(last : last)
    }
    
    func addComma(last : Bool) -> String {
        if !last {
            return ",\n"
        } else {
            return "\n"
        }
    }
    
    func addSpace() -> String {
        return "    "
    }
}
