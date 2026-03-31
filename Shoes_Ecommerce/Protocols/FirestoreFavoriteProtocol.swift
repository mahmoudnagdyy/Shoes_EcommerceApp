//
//  FirestoreFavoriteProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 31/03/2026.
//

import Foundation
internal import Combine


protocol FirestoreFavoriteProtocol {
    func addFavoriteProduct(productId: String) async throws
    func getFavoriteProductsUsingListiner(userId: String) -> AnyPublisher<[ProductModel], Never>
}
