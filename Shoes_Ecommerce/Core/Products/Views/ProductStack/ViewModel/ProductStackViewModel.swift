//
//  ProductStackViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import Foundation
internal import Combine
import FirebaseAuth

class ProductStackViewModel: ObservableObject {
    
    @Published var productCategory: CategoryModel?
    @Published var product: ProductModel
    @Published var sizes: [ProductSizeModel] = []
    @Published var selectedSize: ProductSizeModel?
    
    @Published var productSize: String = ""
    @Published var productSizeStock: String = ""
    
    @Published var user: UserModel?
    
    var cancellables = Set<AnyCancellable>()
    
    let firestoreUserManager: FirestoreUserProtocol
    let firestoreProductManager: FirestoreProductProtocol
    let firestoreCategoryManager: FirestoreCategoryProtocol
    let firestoreFavoriteManager: FirestoreFavoriteProtocol
    let firestoreCartManager: FirestoreCartProtocol
    
    init(
        product: ProductModel,
        firestoreUserManager: FirestoreUserProtocol,
        firestoreProductManager: FirestoreProductProtocol,
        firestoreCategoryManager: FirestoreCategoryProtocol,
        firestoreFavoriteManager: FirestoreFavoriteProtocol,
        firestoreCartManager: FirestoreCartProtocol
    ) {
        self.product = product
        self.firestoreUserManager = firestoreUserManager
        self.firestoreProductManager = firestoreProductManager
        self.firestoreCategoryManager = firestoreCategoryManager
        self.firestoreFavoriteManager = firestoreFavoriteManager
        self.firestoreCartManager = firestoreCartManager
        getProductCategory(categoryId: product.categoryId)
        if !product.id.isEmpty {
            getProductSizes(productId: product.id)
        }
        getAuthenticatedUser()
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
    
    func getProductCategory(categoryId: String) {
        Task {
            do {
                self.productCategory = try await firestoreCategoryManager.getCategory(categoryId: categoryId)
            } catch {
                print(error)
            }
        }
    }
    
    func getProductSizes(productId: String) {
        firestoreProductManager.getProductSizesUsingListener(productId: productId)
            .sink { [weak self] productSizes in
                self?.sizes = productSizes
                self?.selectedSize = productSizes.first
            }
            .store(in: &cancellables)
    }
    
    func saveSize(productId: String) async throws {
        guard let size = Int(productSize),
              let stock = Int(productSizeStock) else {return}
        try await firestoreProductManager.saveSize(productId: productId, size: size, stock: stock)
    }
    
    func getAuthenticatedUser() {
        guard let authedUser = Auth.auth().currentUser else {return}
        Task {
            do {
                self.user = try await firestoreUserManager.getUser(userId: authedUser.uid)
            } catch {
                print(error)
            }
        }
    }
    
}



extension ProductStackViewModel {
    
    func addItemToCart(product: ProductModel) {
        guard let authedUser = Auth.auth().currentUser, let selectedSize else { return }
        Task {
            do {
                try await firestoreCartManager.addItemToCart(userId: authedUser.uid, productId: product.id, sizeId: selectedSize.id)
            } catch {
                print(error)
            }
        }
    }
    
}
