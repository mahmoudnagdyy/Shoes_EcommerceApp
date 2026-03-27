//
//  FavoriteModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import Foundation
import FirebaseCore


struct FavoriteModel: Codable {
    let productId: String
    var createdAt: Timestamp = Timestamp()
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case createdAt = "created_at"
    }
    
    var favDict: [String: Any] {
        return [
            FavoriteModel.CodingKeys.productId.rawValue: productId,
            FavoriteModel.CodingKeys.createdAt.rawValue: createdAt
        ]
    }
}
