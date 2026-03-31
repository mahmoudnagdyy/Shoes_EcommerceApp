//
//  FirestoreCartProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 31/03/2026.
//

import Foundation
internal import Combine


protocol FirestoreCartProtocol {
    func addItemToCart(userId: String, productId: String, sizeId: String) async throws
    func getCartItemsUsingListener(userId: String) -> AnyPublisher<[CartItemModel], Never>
    func incrementItemQuantity(userId: String, productId: String, sizeId: String) async throws
    func decrementItemQuantity(userId: String, productId: String, sizeId: String) async throws
}
