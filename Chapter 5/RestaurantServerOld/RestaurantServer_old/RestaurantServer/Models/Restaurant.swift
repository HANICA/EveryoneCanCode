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
        return "[\n  {\n" + "    \"category\" : [" +  categoriesString + "]\n  }\n]"
    }

    
    func getMenuAsString() -> String {
        var menuString = ""
        var i = 0
        
        for menuitem in self.menu {
            if (i == (self.menu.count - 1)) {
                menuString += "  {\n" + menuitem.printMenuItem() + "  }\n"
            } else {
                menuString += "  {\n" + menuitem.printMenuItem() + "  },\n"
            }
            i += 1
        }
        return "[\n" + menuString + "]"
    }
}