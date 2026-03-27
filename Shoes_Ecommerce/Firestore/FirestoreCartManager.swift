//
//  FirestoreCartManager.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 26/03/2026.
//

import Foundation
import FirebaseFirestore
internal import Combine



class FirestoreCartManager {
    
    static let shared = FirestoreCartManager()
    private let cartCollection = Firestore.firestore().collection("cart")
    
    private init() {}
    
    private func cartDocument(userId: String) -> DocumentReference {
        cartCollection.document(userId)
    }
    
    func addItemToCart(userId: String, productId: String, sizeId: String) async throws {
        let cartDoc = cartCollection.document(userId)
        try await cartDoc.setData(["user_id": userId])
        
        let cartProducts = cartDoc.collection("products")
        let docId = "\(productId)_\(sizeId)"
        let snapshot = try await cartProducts.document(docId).getDocument()
        
        if snapshot.exists {
            try await cartProducts.document(productId).updateData(["quantity": FieldValue.increment(Int64(1))])
        } else{
            let cartItem = CartModel(productId: productId, sizeId: sizeId, quantity: 1)
            try await cartProducts.document(docId).setData(cartItem.cartDic)
        }
    }
    
    func getCartItemsUsingListener(userId: String) -> AnyPublisher<[CartItemModel], Never> {
        let publisher = PassthroughSubject<[CartItemModel], Never>()
        cartDocument(userId: userId).collection("products").order(by: "created_at").addSnapshotListener { snapshot, error in
            guard let snapshot, error == nil else { return }
            let items: [CartModel] = snapshot.getDocuments()
            Task {
                let cartItems = await self.convertCartDocumentsToCartItems(items: items)
                publisher.send(cartItems)
            }
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func incrementItemQuantity(userId: String, productId: String, sizeId: String) async throws {
        let docId = "\(productId)_\(sizeId)"
        try await cartDocument(userId: userId).collection("products").document(docId).updateData(["quantity": FieldValue.increment(Int64(1))])
    }
    
    func decrementItemQuantity(userId: String, productId: String, sizeId: String) async throws {
        let docId = "\(productId)_\(sizeId)"
        let docRef = cartDocument(userId: userId).collection("products").document(docId)
        let cartItem = try await docRef.getDocument(as: CartModel.self)
        if cartItem.quantity > 1 {
            try await docRef.updateData(["quantity": FieldValue.increment(Int64(-1))])
        } else{
            try await docRef.delete()
        }
    }
    
    private func convertCartDocumentsToCartItems(items: [CartModel]) async -> [CartItemModel] {
        var cartItems: [CartItemModel] = []
            do {
                for item in items {
                    let product = try await FirestoreProductManager.shared.getProduct(productId: item.productId)
                    let size = try await FirestoreProductManager.shared.getSize(productId: product.id, sizeId: item.sizeId)
                    let cartItem = CartItemModel(id: item.id, product: product, size: size, quantity: item.quantity)
                    cartItems.append(cartItem)
                }
            } catch {
                print(error)
            }
        
        return cartItems
    }
    
}
