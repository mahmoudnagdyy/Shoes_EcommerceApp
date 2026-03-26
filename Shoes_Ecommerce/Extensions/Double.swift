//
//  Double.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 26/03/2026.
//

import Foundation



extension Double {
    
    func asPriceString() -> String {
        return "$ " + String(format: "%.2f", self)
    }
    
}
