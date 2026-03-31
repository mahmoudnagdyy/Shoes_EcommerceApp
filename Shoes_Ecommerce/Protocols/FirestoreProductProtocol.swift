//
//  FirestoreProductProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 31/03/2026.
//

import Foundation
internal import Combine
import FirebaseFirestore



protocol FirestoreProductProtocol {
    func createProduct(productName: String, categoryId: String, productDescription: String, productPrice: Double, images: [ImageModel]) async throws
    func getProductsUsingListener() -> AnyPublisher<[ProductModel], Never>
    func getProduct(productId: String) async throws -> ProductModel
    func getProductWithPagination(limit: Int, lastDocument: DocumentSnapshot?) async throws  -> (products: [ProductModel], lastDocument: DocumentSnapshot?, hasMore: Bool)
    func saveSize(productId: String, size: Int, stock: Int) async throws
    func getProductSizesUsingListener(productId: String) -> AnyPublisher<[ProductSizeModel], Never>
    func getSize(productId: String, sizeId: String) async throws -> ProductSizeModel
}
