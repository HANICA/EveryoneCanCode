//
//  Settings.swift
//  RestaurantServer
//
//  Created by J.A. Korten on 03-04-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import Foundation

struct Settings: Codable {
    var serverPort : UInt16 = 8080
    var showHostname : Bool = true
    var homeHTML : String = "RestaurantServer is running"
}
