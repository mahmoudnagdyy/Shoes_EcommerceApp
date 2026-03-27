//
//  CategoryModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import Foundation
import FirebaseCore


struct CategoryModel: Codable, Identifiable, Hashable {
    
    let id: String
    let categoryName: String
    let image: ImageModel
    let createdAt: Timestamp = Timestamp()
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case image
        case createdAt = "created_at"
    }
    
    var categoryDict: [String: Any] {
        return [
            CategoryModel.CodingKeys.id.rawValue: id,
            CategoryModel.CodingKeys.categoryName.rawValue: categoryName.lowercased(),
            CategoryModel.CodingKeys.image.rawValue: [
                "public_id": image.publicId,
                "secure_url": image.secureUrl
            ],
            CategoryModel.CodingKeys.createdAt.rawValue: createdAt
        ]
    }
    
    static func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        lhs.id == rhs.id
    }
}
