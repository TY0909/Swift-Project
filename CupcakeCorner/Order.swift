//
//  Order.swift
//  CupcakeCorner
//
//  Created by M Sapphire on 2023/12/9.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
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
    
    var name = "" {
        didSet {
            if let decoded = try? JSONEncoder().encode(name) {
                UserDefaults.standard.set(decoded, forKey: "name")
            }
        }
    }
    var streetAddress = "" {
        didSet {
            if let decoded = try? JSONEncoder().encode(streetAddress) {
                UserDefaults.standard.set(decoded, forKey: "streetAddress")
            }
        }
    }
    var city = "" {
        didSet {
            if let decoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(decoded, forKey: "city")
            }
        }
    }
    var zip = "" {
        didSet {
            if let decoded = try? JSONEncoder().encode(zip) {
                UserDefaults.standard.set(decoded, forKey: "zip")
            }
        }
    }
    
    func isAddressValid() -> Bool{
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        if name.contains(" ") || streetAddress.contains(" ") || city.contains(" ") || zip.contains(" ") {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    init() {
        if let savedName = UserDefaults.standard.data(forKey: "name") {
            if let decoded = try? JSONDecoder().decode(String.self, from: savedName) {
                name = decoded
            }
        }
        
        if let savedStreet = UserDefaults.standard.data(forKey: "streetAddress") {
            if let decoded = try? JSONDecoder().decode(String.self, from: savedStreet) {
                streetAddress = decoded
            }
        }
        
        if let savedCity = UserDefaults.standard.data(forKey: "city") {
            if let decoded = try? JSONDecoder().decode(String.self, from: savedCity) {
                city = decoded
            }
        }
        
        if let savedZip = UserDefaults.standard.data(forKey: "zip") {
            if let decoded = try? JSONDecoder().decode(String.self, from: savedZip) {
                zip = decoded
            }
        }
    }
}
