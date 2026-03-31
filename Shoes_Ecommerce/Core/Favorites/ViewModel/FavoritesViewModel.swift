//
//  FavoritesViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import Foundation
internal import Combine
import FirebaseAuth


@MainActor
class FavoritesViewModel: ObservableObject {
    
    @Published var favoriteProducts: [ProductModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let firestoreFavoriteManager: FirestoreFavoriteProtocol = FirestoreFavoriteManager()
    
    init() {
        getFavoriteProducts()
    }
    
    private func getFavoriteProducts() {
        guard let authedUser = Auth.auth().currentUser else {return}
        firestoreFavoriteManager.getFavoriteProductsUsingListiner(userId: authedUser.uid)
            .sink { [weak self] returnedFavProducts in
                self?.favoriteProducts = returnedFavProducts
            }
            .store(in: &cancellables)
    }
    
    func addFavoriteProduct(product: ProductModel) {
        Task {
            do {
                try await firestoreFavoriteManager.addFavoriteProduct(productId: product.id)
            } catch {
                print(error)
            }
        }
    }
    
}
