//
//  ProductSizeModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import Foundation



struct ProductSizeModel: Identifiable, Codable, Equatable {
    let id: String
    let size: Int
    let stock: Int
    
    enum CodingKeys: String, CodingKey {
        case id, size, stock
    }
    
    var sizeDict: [String: Any] {
        return [
            ProductSizeModel.CodingKeys.id.rawValue: id,
            ProductSizeModel.CodingKeys.size.rawValue: size,
            ProductSizeModel.CodingKeys.stock.rawValue: stock
        ]
    }
    
    static func ==(lhs: ProductSizeModel, rhs: ProductSizeModel) -> Bool {
        lhs.id == rhs.id
    }
}
