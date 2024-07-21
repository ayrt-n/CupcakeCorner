//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ayrton Parkinson on 2024/07/21.
//

import Foundation

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    let saveKey = "orderDetails"
    
    func save() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(self) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
    
    var type = 0 {
        didSet {
            save()
        }
    }
    var quantity = 3 {
        didSet {
            save()
        }
    }
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
            save()
        }
    }
    
    var extraFrosting = false {
        didSet {
            save()
        }
    }
    var addSprinkles = false {
        didSet {
            save()
        }
    }
    
    var name = "" {
        didSet {
            save()
        }
    }
    var streetAddress = "" {
        didSet {
            save()
        }
    }
    var city = "" {
        didSet {
            save()
        }
    }
    var zip = "" {
        didSet {
            save()
        }
    }
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        cost += Decimal(type) / 2
        if extraFrosting { cost += Decimal(quantity) }
        if addSprinkles { cost += Decimal(quantity) / 2 }
        
        return cost
    }
    
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
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode(Order.self, from: savedItems) {
                type = decodedItems.type
                quantity = decodedItems.quantity
                specialRequestEnabled = decodedItems.specialRequestEnabled
                extraFrosting = decodedItems.extraFrosting
                addSprinkles = decodedItems.addSprinkles
                name = decodedItems.name
                city = decodedItems.city
                streetAddress = decodedItems.streetAddress
                zip = decodedItems.zip
                
                return
            }
        }
        
        type = 0
        quantity = 3
        specialRequestEnabled = false
        extraFrosting = false
        addSprinkles = false
        name = ""
        city = ""
        streetAddress = ""
        zip = ""
    }
}
