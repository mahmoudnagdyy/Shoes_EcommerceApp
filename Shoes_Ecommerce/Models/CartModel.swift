//
//  CartModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 26/03/2026.
//

import Foundation



struct CartModel: Codable, Identifiable {
    var id: String = UUID().uuidString
    let productId: String
    let sizeId: String
    let quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case sizeId = "size_id"
        case quantity
    }
    
    var cartDic: [String: Any] {
        return [
            CartModel.CodingKeys.id.rawValue: id,
            CartModel.CodingKeys.productId.rawValue: productId,
            CartModel.CodingKeys.sizeId.rawValue: sizeId,
            CartModel.CodingKeys.quantity.rawValue: quantity,
        ]
    }
}


struct CartItemModel: Codable, Identifiable {
    let id: String
    let product: ProductModel
    let size: ProductSizeModel
    let quantity: Int
    
    
    var totalPrice: Double {
        return Double(quantity) * product.price
    }
}
