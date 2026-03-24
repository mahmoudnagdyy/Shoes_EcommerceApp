//
//  UploadCategoryPhotoService.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import Foundation
import SwiftUI


class CategoryService {
    
    static let shared = CategoryService()
    
    private init() {}
    
    
    func uploadCategoryPhoto(categoryName: String, image: UIImage) async throws -> ImageModel {
        guard let url = URL(string: "http://localhost:5050/category") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // userId
        data.append("--\(boundary)\r\n")
        data.append("Content-Disposition: form-data; name=\"categoryName\"\r\n\r\n")
        data.append("\(categoryName)\r\n")
        
        // image
        let imageData = image.jpegData(compressionQuality: 0.8)!
        
        data.append("--\(boundary)\r\n")
        data.append("Content-Disposition: form-data; name=\"image\"; filename=\"profile.jpg\"\r\n")
        data.append("Content-Type: image/jpeg\r\n\r\n")
        data.append(imageData)
        data.append("\r\n")
        data.append("--\(boundary)--\r\n")
        
        request.httpBody = data
        
        let (returnedData, _) = try await URLSession.shared.data(for: request)
        
        let decodedData = try JSONDecoder().decode(uploadCategoryPhotoResponseModel.self, from: returnedData)
        return decodedData.image
    }
    
}


struct uploadCategoryPhotoResponseModel: Codable {
    let message: String
    let image: ImageModel
}
