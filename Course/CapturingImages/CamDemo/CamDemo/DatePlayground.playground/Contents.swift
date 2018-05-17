//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground, moment is:"
print (str)


func currentMomentToString() -> String {
    let date = Date()
    let calendar = Calendar.current
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date)
    let year = calendar.component(.year, from: date)
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let second = calendar.component(.second, from: date)
    return "\(day)\(month)\(year)\(hour)\(minutes)\(second)"
    
}

print (currentMomentToString())

