//
//  Restaurant.swift
//  RestaurantServerApp
//
//  Created by J.A. Korten on 02-04-18.
//

import Foundation

class Restaurant {
    var menu:Array<Menu> = []
    
    
    func getCategoryArray() -> [String]? {
        // get all unique categories for menu
        var categories = [String]()
        
        for menuitem in self.menu {
            if !categories.contains(menuitem.category) {
                categories.append(menuitem.category)
            }
        }
        return categories
    }
    
    func getCategoriesAsString() -> String {
        // get all unique categories for menu
        var categoriesString = ""
        var i = 0
        if let categories = getCategoryArray() {
            for category in categories {
                if (i == (categories.count - 1)) {
                    categoriesString += "\"" + category + "\""
                } else {
                    categoriesString += "\"" + category + "\", "
                }
                i += 1
            }
        }
        //return "{" +  categoriesString + "}"
        // {"categories":["entrees","appetizers","main course"]}

        return "{\"categories\":[" + categoriesString + "]}"
    }
    
    // appDelegate.restaurant.getCategories(category : name)

    func getCategories(category : String) -> String {
        // get all unique categories for menu
        var menuString = ""
        
        for menuitem in self.menu {
            if menuitem.category == category {
                menuString += "{" + menuitem.printMenuItem() + "},"
            }
        }
        if (menuString.last == ",") {
          menuString = String(menuString.dropLast()) // remove last ","
        }
        return "{\"items\":[" + menuString + "]}"
    }
    
    func getMenuAsString() -> String {
        var menuString = ""
        var i = 0
        
        for menuitem in self.menu {
            if (i == (self.menu.count - 1)) {
                menuString += "{" + menuitem.printMenuItem() + "}"
            } else {
                menuString += "{" + menuitem.printMenuItem() + "},"
            }
            i += 1
        }
        return "{\"items\":[" + menuString + "]}"
    }
}

/*{"items":[{"category":"Entrees","id":0,"image_url":"nu.nl","name":"test","description":"testitem 1","price":1},{"category":"Entrees","id":0,"image_url":"nu.nl","name":"test","description":"testitem 1","price":1}]}*/


