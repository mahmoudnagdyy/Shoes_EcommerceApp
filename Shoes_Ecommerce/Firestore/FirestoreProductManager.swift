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
        
        let query = productsCollection.order(by: "created_at")
        
        query.addSnapshotListener { snapshot, error in
            guard let snapshot, error == nil else {return}
            let products: [ProductModel] = snapshot.getDocuments()
            publisher.send(products)
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func getProduct(productId: String) async throws -> ProductModel {
        try await productDocument(productId: productId).getDocument(as: ProductModel.self)
    }
    
    func getProductWithPagination(limit: Int, lastDocument: DocumentSnapshot?) async throws  -> (products: [ProductModel], lastDocument: DocumentSnapshot?, hasMore: Bool) {
        var query = productsCollection.order(by: "created_at").limit(to: limit)
        
        if let lastDocument {
            query = query.start(afterDocument: lastDocument)
        }
        
        let snapshot = try await query.getDocuments()
        let products: [ProductModel] = snapshot.getDocuments()
        
        let newLastDocument = snapshot.documents.last
        let hasMore = snapshot.documents.count == limit
                
        return (products, newLastDocument, hasMore)
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
        productDocument(productId: productId).collection("sizes").order(by: "size").addSnapshotListener { snapshot, error in
            guard let snapshot, error == nil else { return }
            let sizes: [ProductSizeModel] = snapshot.getDocuments()
            publisher.send(sizes)
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func getSize(productId: String, sizeId: String) async throws -> ProductSizeModel {
        try await productDocument(productId: productId).collection("sizes").document(sizeId).getDocument(as: ProductSizeModel.self)
    }
    
}
