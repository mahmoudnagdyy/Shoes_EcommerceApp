//
//  DashboardViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import Foundation
internal import Combine
import _PhotosUI_SwiftUI

@MainActor
class DashboardViewModel: ObservableObject {
    
    // MARK: CATEGORIES - PROPERITIES
    
    @Published var Categoryimage: UIImage?
    @Published var selectedCategoryImage: PhotosPickerItem? {
        didSet {
            convertCategoryPhotoPickerToUIImage(selectedCategoryImage: selectedCategoryImage)
        }
    }
    @Published var categoryName: String = ""
    @Published var categories: [CategoryModel] = []
    var cancellables = Set<AnyCancellable>()
    
    
    
    // MARK: PRODUCTS - PROPERITIES
    @Published var productName: String = ""
    @Published var productCategory: CategoryModel?
    @Published var productDescription: String = ""
    @Published var productPrice: String = ""
    @Published var productImages: [UIImage]? = nil
    @Published var selectedProductImages: [PhotosPickerItem] = [] {
        didSet {
            convertProductPhotoPickerItemsToUIImages(selectedProductImages: selectedProductImages)
        }
    }
    @Published var products: [ProductModel] = []
    
    
    
    init() {
        getCategories()
        getProducts()
    }
    
    
    
}


// MARK: CATEGORIES - FUNCTION
extension DashboardViewModel {
    
    func createCategory() async throws {
        guard let Categoryimage, !categoryName.isEmpty else {return}
        let returnedImage = try await CategoryService.shared.uploadCategoryPhoto(categoryName: categoryName, image: Categoryimage)
        try await FirestoreCategoryManager.shared.createCategory(categoryName: categoryName, categoryImage: returnedImage)
    }
    
    func getCategories() {
        FirestoreCategoryManager.shared.getCategoriesUsingLisitner()
            .sink { [weak self] returnedCategories in
                self?.categories = returnedCategories
                
                if self?.productCategory == nil {
                    self?.productCategory = returnedCategories.first
                }
            }
            .store(in: &cancellables)
    }
    
}


// MARK: PRODUCTS - FUNCTION
extension DashboardViewModel {
    
    func createProduct() async throws {
        guard !productName.isEmpty,
              !productDescription.isEmpty,
              let productImages,
              let productCategory,
              let productPrice = Double(productPrice) else {return}
        let returnedImages = try await ProductService.shared.uploadImages(images: productImages)
        try await FirestoreProductManager.shared.createProduct(
            productName: productName,
            categoryId: productCategory.id,
            productDescription: productDescription,
            productPrice: productPrice,
            images: returnedImages)
    }
    
    func getProducts() {
        FirestoreProductManager.shared.getProductsUsingListener()
            .sink { [weak self] returnedProducts in
                self?.products = returnedProducts
            }
            .store(in: &cancellables)
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
    
    
}






extension DashboardViewModel {
    
    private func convertProductPhotoPickerItemsToUIImages(selectedProductImages: [PhotosPickerItem]) {
        var images: [UIImage] = []
        Task {
            for selectedProductImage in selectedProductImages {
                do {
                    let imageData = try await selectedProductImage.loadTransferable(type: Data.self)
                    if let imageData,
                       let newImage = UIImage(data: imageData) {
                        images.append(newImage)
                    }
                } catch {
                    print(error)
                }
            }
            productImages = images
        }
        
    }
    
    
    private func convertCategoryPhotoPickerToUIImage(selectedCategoryImage: PhotosPickerItem?) {
        Task {
            do {
                let imageData = try await selectedCategoryImage?.loadTransferable(type: Data.self)
                if let imageData {
                    Categoryimage = UIImage(data: imageData)
                }
            } catch {
                print(error)
            }
        }
    }
    
}
