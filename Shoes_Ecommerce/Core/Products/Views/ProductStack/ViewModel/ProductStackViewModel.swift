//
//  ProductStackViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import Foundation
internal import Combine

class ProductStackViewModel: ObservableObject {
    
    @Published var productCategory: CategoryModel?
    @Published var product: ProductModel
    @Published var sizes: [ProductSizeModel] = []
    @Published var selectedSize: ProductSizeModel?
    
    @Published var productSize: String = ""
    @Published var productSizeStock: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init(product: ProductModel) {
        self.product = product
        getProductCategory(categoryId: product.categoryId)
        if !product.id.isEmpty {
            getProductSizes(productId: product.id)
        }
    }
    
    func makeProductFavorite(product: ProductModel) {
        Task {
            do {
                try await FirestoreProductManager
                    .shared
                    .makeProductFavorite(productId: product.id, isFavorite: product.isFavorite)
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
    
}
