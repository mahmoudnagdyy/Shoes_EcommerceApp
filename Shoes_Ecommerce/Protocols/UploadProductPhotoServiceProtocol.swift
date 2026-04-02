//
//  UploadProductPhotoServiceProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 02/04/2026.
//

import Foundation
import SwiftUI


protocol UploadProductPhotoServiceProtocol {
    func uploadImages(images: [UIImage]) async throws -> [ImageModel]
}
