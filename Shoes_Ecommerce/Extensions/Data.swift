//
//  Data.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import Foundation


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
