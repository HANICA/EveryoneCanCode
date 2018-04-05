//
//  UIHelper.swift
//  RestaurantServer
//
//  Created by J.A. Korten on 04-04-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import Foundation

func getTime() -> String {
    let date = Date()
    let calendar = Calendar.current
    
    var hour = "\(calendar.component(.hour, from: date))"
    var minutes = "\(calendar.component(.minute, from: date))"
    var seconds = "\(calendar.component(.second, from: date))"
    
    if (hour.count < 2) {
        hour = "0" + hour
    }
    if (minutes.count < 2) {
        minutes = "0" + minutes
    }
    if (seconds.count < 2) {
        seconds = "0" + seconds
    }
    let str = "\(hour):\(minutes):\(seconds): "
    return str
    
}


