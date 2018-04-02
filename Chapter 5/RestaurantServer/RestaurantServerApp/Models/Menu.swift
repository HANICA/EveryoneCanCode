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
        result += formatItem(item : id, last : false)
        result += formatItem(item : name, last : false)
        result += formatItem(item : description, last : false)
        result += formatItem(item : price, last : false)
        result += formatItem(item : category, last : false)
        result += formatItem(item : imageName, last : true)

        //result = "{\n" + result + "\n}"
        return result
    }
    
    func formatItem(item : Int, last : Bool) -> String {
        return addSpace() + "\"\(item)\" : \(item)" + addComma(last : last)
    }
    
    func formatItem(item : Double, last : Bool) -> String {
        return addSpace() + "\"\(item)\" : \(item)" + addComma(last : last)
    }
    
    func formatItem(item : String, last : Bool) -> String {
        return addSpace() + "\"\(item)\" : \"\(item)\"" + addComma(last : last)
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
