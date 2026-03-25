//
//  FirestoreProductManager.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import Foundation
import FirebaseFirestore
internal import Combine


class FirestoreProductManager {
    
    static let shared = FirestoreProductManager()
    private let productsCollection = Firestore.firestore().collection("products")
    
    private init() {}
    
    private func productDocument(productId: String) -> DocumentReference {
        productsCollection.document(productId)
    }
    
    func createProduct(productName: String, categoryId: String, productDescription: String, productPrice: Double, images: [ImageModel]) async throws {
        let query = productsCollection.document()
        let product = ProductModel(
            id: query.documentID,
            productName: productName,
            categoryId: categoryId,
            description: productDescription,
            images: images,
            price: productPrice
        )
        try await query.setData(product.productDict)
    }
    
    
    func getProductsUsingListener() -> AnyPublisher<[ProductModel], Never> {
        let publisher = PassthroughSubject<[ProductModel], Never>()
        productsCollection.addSnapshotListener { snapshot, error in
            guard let snapshot, error == nil else {return}
            let products: [ProductModel] = snapshot.getDocuments()
            publisher.send(products)
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func makeProductFavorite(productId: String, isFavorite: Bool) async throws {
        try await productDocument(productId: productId).updateData([
            ProductModel.CodingKeys.isFavorite.rawValue : !isFavorite
        ])
    }
    
}


// MARK: SIZES
extension FirestoreProductManager {
    
    func saveSize(productId: String, size: Int, stock: Int) async throws {
        let query = productDocument(productId: productId).collection("sizes").document()
        let newSize = ProductSizeModel(id: query.documentID, size: size, stock: stock)
        try await query.setData(newSize.sizeDict)
    }
    
    func getProductSizesUsingListener(productId: String) -> AnyPublisher<[ProductSizeModel], Never> {
        let publisher = PassthroughSubject<[ProductSizeModel], Never>()
        productDocument(productId: productId).collection("sizes").addSnapshotListener { snapshot, error in
            guard let snapshot, error == nil else { return }
            var sizes: [ProductSizeModel] = snapshot.getDocuments()
            sizes.sort(by: {$0.size < $1.size})
            publisher.send(sizes)
        }
        return publisher.eraseToAnyPublisher()
    }
    
}
