//
//  UploadCategoryPhotoServiceProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 02/04/2026.
//

import Foundation
import SwiftUI

protocol UploadCategoryPhotoServiceProtocol {
    func uploadCategoryPhoto(categoryName: String, image: UIImage) async throws -> ImageModel
}
