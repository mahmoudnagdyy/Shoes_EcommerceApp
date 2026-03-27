//
//  FirestoreFavoriteManager.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
internal import Combine

class FirestoreFavoriteManager {
    
    static let shared = FirestoreFavoriteManager()
    private let favoritesCollection = Firestore.firestore().collection("favorites")
    
    private init() {}
    
    private func favoriteDocument(userId: String) -> DocumentReference {
        favoritesCollection.document(userId)
    }
    
    private func favoriteProductsCollection(userId: String) -> CollectionReference {
        favoritesCollection.document(userId).collection("products")
    }
    
    func addFavoriteProduct(productId: String) async throws {
        guard let authedUser = Auth.auth().currentUser else {return}
        
        let productDoc = favoriteProductsCollection(userId: authedUser.uid).document(productId)
        let snapshot = try await productDoc.getDocument()
        
        if snapshot.exists {
            try await productDoc.delete()
        } else{
            try await favoriteDocument(userId: authedUser.uid).setData(["userId": authedUser.uid])
            let favItem = FavoriteModel(productId: productId)
            try await favoriteProductsCollection(userId: authedUser.uid).document(productId).setData(favItem.favDict)
        }
    }
    
    func getFavoriteProductsUsingListiner(userId: String) -> AnyPublisher<[ProductModel], Never> {
        let publisher = PassthroughSubject<[ProductModel], Never>()
        favoriteProductsCollection(userId: userId).order(by: "created_at").addSnapshotListener { snapshot, error in
            guard let snapshot, error == nil else {return}
            let favs: [FavoriteModel] = snapshot.getDocuments()
            var products: [ProductModel] = []
            Task {
                do {
                    for fav in favs {
                        let product = try await FirestoreProductManager.shared.getProduct(productId: fav.productId)
                        products.append(product)
                    }
                    publisher.send(products)
                } catch {
                    print(error)
                }
            }
        }
        return publisher.eraseToAnyPublisher()
    }
    
}
