//
//  Order.swift
//  100DaysOfSwiftUI
//
//  Created by MrJeris on 07.05.2023.
//

import SwiftUI

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
        
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    //Challenges #1
    func isEmptyInput(value: String) -> Bool {
        !value.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var hasValidAddress: Bool {
        if !isEmptyInput(value: name) || !isEmptyInput(value: streetAddress) || !isEmptyInput(value: city) || !isEmptyInput(value: zip) {
            return false
        }
        return true
    }
    
    var cost: Double {
        // 2$ per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // 1$ / cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
