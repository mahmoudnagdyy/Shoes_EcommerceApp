//
//  UserModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
import FirebaseAuth


struct ImageModel: Codable {
    let publicId: String
    let secureUrl: String
    
    enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case secureUrl = "secure_url"
    }
}


struct UserModel: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let photoUrl: String?
    let image: ImageModel?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case photoUrl = "photo_url"
        case image
    }
    
    
    var userDict: [String: Any] {
        return [
            UserModel.CodingKeys.id.rawValue: id,
            UserModel.CodingKeys.firstName.rawValue: firstName.lowercased(),
            UserModel.CodingKeys.lastName.rawValue: lastName.lowercased(),
            UserModel.CodingKeys.email.rawValue: email.lowercased(),
            UserModel.CodingKeys.photoUrl.rawValue: photoUrl ?? "",
        ]
    }
}
