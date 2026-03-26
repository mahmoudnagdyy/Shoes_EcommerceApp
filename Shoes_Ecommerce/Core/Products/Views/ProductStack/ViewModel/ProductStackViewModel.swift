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
    
    init(product: ProductModel) {
        self.product = product
        getProductCategory(categoryId: product.categoryId)
        if !product.id.isEmpty {
            getProductSizes(productId: product.id)
        }
        getAuthenticatedUser()
    }
    
    func addFavoriteProduct(product: ProductModel) {
        Task {
            do {
                try await FirestoreFavoriteManager.shared.addFavoriteProduct(productId: product.id)
            } catch {
                print(error)
            }
        }
    }
    
    func getProductCategory(categoryId: String) {
        Task {
            do {
                self.productCategory = try await FirestoreCategoryManager.shared.getCategory(categoryId: categoryId)
            } catch {
                print(error)
            }
        }
    }
    
    func getProductSizes(productId: String) {
        FirestoreProductManager.shared.getProductSizesUsingListener(productId: productId)
            .sink { [weak self] productSizes in
                self?.sizes = productSizes
                self?.selectedSize = productSizes.first
            }
            .store(in: &cancellables)
    }
    
    func saveSize(productId: String) async throws {
        guard let size = Int(productSize),
              let stock = Int(productSizeStock) else {return}
        try await FirestoreProductManager.shared.saveSize(productId: productId, size: size, stock: stock)
    }
    
    func getAuthenticatedUser() {
        guard let authedUser = Auth.auth().currentUser else {return}
        Task {
            do {
                self.user = try await FirestoreUserManager.shared.getUser(userId: authedUser.uid)
            } catch {
                print(error)
            }
        }
    }
    
}
