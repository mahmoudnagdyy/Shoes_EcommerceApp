//
//  ProductModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import Foundation


struct ProductModel: Codable, Identifiable, Hashable {
    let id: String
    let productName: String
    let categoryId: String
    let description: String
    let images: [ImageModel]
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case productName = "product_name"
        case categoryId = "category_id"
        case description
        case images
        case price
    }
    
    var productDict: [String: Any] {
        return [
            ProductModel.CodingKeys.id.rawValue: id,
            ProductModel.CodingKeys.productName.rawValue: productName.lowercased(),
            ProductModel.CodingKeys.categoryId.rawValue: categoryId,
            ProductModel.CodingKeys.description.rawValue: description.lowercased(),
            ProductModel.CodingKeys.price.rawValue: price,
            ProductModel.CodingKeys.images.rawValue: images.map({ image in
                return [
                    "public_id": image.publicId,
                    "secure_url": image.secureUrl
                ]
            }),
        ]
    }
}
