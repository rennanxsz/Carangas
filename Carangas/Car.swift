//
//  Car.swift
//  Carangas
//
//  Created by Rennan Bruno on 11/03/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

class Car: Codable {
    
    var _id: String
    var brand: String
    var gasType: Int
    var name: String
    var price: Double
    
    var gas: String {
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Álcool"
        default:
            return "Gasolina"
        }
    }
    
}
