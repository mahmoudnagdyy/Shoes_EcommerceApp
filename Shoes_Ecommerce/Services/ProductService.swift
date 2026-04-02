//
//  ProductService.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import Foundation
import SwiftUI


class ProductService: UploadProductPhotoServiceProtocol {
    
    func uploadImages(images: [UIImage]) async throws -> [ImageModel] {
        guard let url = URL(string: "http://localhost:5050/product") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        for (index, image) in images.enumerated() {
            let imageData = image.jpegData(compressionQuality: 0.8)!
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"images\"; filename=\"image\(index).jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: body)
        let returnedData = try JSONDecoder().decode(uploadProductImageResponseModel.self, from: data)
        return returnedData.images
    }
    
}


struct uploadProductImageResponseModel: Codable {
    let message: String
    let images: [ImageModel]
}
