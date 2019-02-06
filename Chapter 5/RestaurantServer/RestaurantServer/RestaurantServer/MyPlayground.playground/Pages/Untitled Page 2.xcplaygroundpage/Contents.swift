//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        case imageURL = "image_url"
    }
}

struct MenuItems: Codable {
    let items: [MenuItem]
}

let menuItem1 : MenuItem = MenuItem(id: 0, name: "test", description: "testitem 1", price: 1.0, category: "Entrees", imageURL: URL(string: "")!)
let menuItem2 : MenuItem = MenuItem(id: 0, name: "test", description: "testitem 1", price: 1.0, category: "Entrees", imageURL: URL(string: "")!)

var menu : MenuItems = MenuItems(items: [menuItem1, menuItem2])

/*
 var menu : [String] = []
 mycats.append("entrees")
 mycats.append("appetizers")
 mycats.append("main course")
 */

let jsonDataMenu = try? JSONEncoder().encode(menu)
let string2 = String(data: jsonDataMenu!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
print(string2)

//: [Next](@next)
