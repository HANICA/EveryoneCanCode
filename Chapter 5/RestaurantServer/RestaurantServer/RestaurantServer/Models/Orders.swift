//
//  Orders.swift
//  RestaurantServer
//
//  Created by J.A. Korten on 05-04-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import Foundation

// Body:

struct Order: Codable {
    var menuIds : [Int]
    
    func decodeOrder(data : Data) -> Int {
        // e.g. {"menuIds":[4,9]}
        let jsonDecoder = JSONDecoder()
        
        var totalPrepTime = 10

        if let order = try? jsonDecoder.decode(Order.self, from: data) {
          print(order)
          totalPrepTime = order.computePrepTime()
        }
        return totalPrepTime
    }
    
    func computePrepTime() -> Int {
        // some magical function to compute preparation time
        var prepTime = 0
        for menuItem in self.menuIds {
            let randomFactor = Int.random(max: 3) + Int.random(max: prepTime)
            prepTime += 5 + randomFactor
        }
        return prepTime
    }
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}

extension Int {
    static func random(max: Int) -> Int {
        let rnd = Int(arc4random_uniform(UInt32(max) + 1))
        return rnd
    }
}
