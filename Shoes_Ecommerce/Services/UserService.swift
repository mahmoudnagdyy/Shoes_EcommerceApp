//
//  UploadPhotoService.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import Foundation
import UIKit

class UserService {
    
    static let shared = UserService()
    
    private init() {}
    
    
    func uploadPhoto(userId: String, image: UIImage) async throws -> ImageModel {
        guard let url = URL(string: "http://localhost:5050/user") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // userId
        data.append("--\(boundary)\r\n")
        data.append("Content-Disposition: form-data; name=\"userId\"\r\n\r\n")
        data.append("\(userId)\r\n")
        
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
        
        let decodedData = try JSONDecoder().decode(uploadUserPhotoResponseModel.self, from: returnedData)
        return decodedData.image
    }
    
}


struct uploadUserPhotoResponseModel: Codable {
    let message: String
    let image: ImageModel
}
