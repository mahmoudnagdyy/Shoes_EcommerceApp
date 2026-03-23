//
//  FirestoreCategoryManager.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import Foundation
internal import Combine
import FirebaseFirestore

class FirestoreCategoryManager {
    
    static let shared = FirestoreCategoryManager()
    private let categoriesCollection = Firestore.firestore().collection("categories")
    
    private init() {}
    
    private func categoryDocument(categoryId: String) -> DocumentReference {
        categoriesCollection.document(categoryId)
    }
    
    func createCategory(categoryName: String, categoryImage: ImageModel) async throws {
        let query = categoriesCollection.document()
        let category = CategoryModel(id: query.documentID, categoryName: categoryName, image: categoryImage)
        try await query.setData(category.categoryDict)
    }
    
    func getCategoriesUsingLisitner() -> AnyPublisher<[CategoryModel], Never> {
        let publisher = PassthroughSubject<[CategoryModel], Never>()
        categoriesCollection.addSnapshotListener { snapshot, error in
            guard let snapshot, error == nil else { return }
            let categories: [CategoryModel] = snapshot.getDocuments()
            publisher.send(categories)
        }
        return publisher.eraseToAnyPublisher()
    }
    
}
