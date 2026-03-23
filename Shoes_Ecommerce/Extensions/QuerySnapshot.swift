//
//  QuerySnapshot.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import Foundation
import FirebaseFirestore


extension QuerySnapshot {
    
    func getDocuments<T: Codable>() -> [T] {
        var items: [T] = []
        for document in documents {
            do {
                let item = try document.data(as: T.self)
                items.append(item)
            } catch {
                print(error)
            }
        }
        return items
    }
    
}
