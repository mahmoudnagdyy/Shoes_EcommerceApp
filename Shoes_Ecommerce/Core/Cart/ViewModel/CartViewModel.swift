//
//  CartViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 26/03/2026.
//

import Foundation
internal import Combine
import FirebaseAuth


@MainActor
class CartViewModel: ObservableObject {
    
    @Published var cartItems: [CartItemModel] = []
    private var cancellables: Set<AnyCancellable> = []
    
    var totalCartPrice: Double {
        cartItems.reduce(0) { partialResult, cartItem in
            partialResult + (Double(cartItem.quantity) * cartItem.product.price)
        }
    }
    
    init() {
        addSubsribers()
    }
    
    func addSubsribers() {
        getCartItems()
    }
    
    func getCartItems() {
        guard let authedUser = Auth.auth().currentUser else { return }
        FirestoreCartManager.shared.getCartItemsUsingListener(userId: authedUser.uid)
            .sink { [weak self] returnedCartItems in
                self?.cartItems = returnedCartItems
            }
            .store(in: &cancellables)
    }
    
    func increaseQuantity(of cartItem: CartItemModel, sizeId: String) {
        guard let authedUser = Auth.auth().currentUser else { return }
        Task {
            do {
                try await FirestoreCartManager.shared.incrementItemQuantity(
                    userId: authedUser.uid,
                    productId: cartItem.product.id,
                    sizeId: sizeId
                )
            } catch {
                print(error)
            }
        }
    }
    
    func decreaseQuantity(of cartItem: CartItemModel, sizeId: String) {
        guard let authedUser = Auth.auth().currentUser else { return }
        Task {
            do {
                try await FirestoreCartManager.shared.decrementItemQuantity(
                    userId: authedUser.uid,
                    productId: cartItem.product.id,
                    sizeId: sizeId
                )
            } catch {
                print(error)
            }
        }
    }
    
}
