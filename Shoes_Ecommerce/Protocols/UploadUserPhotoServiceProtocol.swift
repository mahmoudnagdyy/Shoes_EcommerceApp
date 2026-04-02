//
//  UploadPhotoServiceProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 02/04/2026.
//

import Foundation
import SwiftUI


protocol UploadUserPhotoServiceProtocol {
    func uploadPhoto(userId: String, image: UIImage) async throws -> ImageModel
}
