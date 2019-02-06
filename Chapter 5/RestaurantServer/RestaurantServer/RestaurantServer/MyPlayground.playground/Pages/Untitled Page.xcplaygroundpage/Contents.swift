//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}

var mycats : [String] = []
mycats.append("entrees")
mycats.append("appetizers")
mycats.append("main course")

let cats = Categories(categories: mycats)
let encodedData = try? JSONEncoder().encode(cats)
let jsonData = try? JSONEncoder().encode(cats)
let string1 = String(data: jsonData!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
print(string1)





