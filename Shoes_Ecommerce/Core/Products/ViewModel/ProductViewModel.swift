//
//  ProductViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import Foundation
internal import Combine
import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseFirestore


@MainActor
class ProductViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    @Published var productName: String = ""
    @Published var productCategory: CategoryModel?
    @Published var productPrice: String = ""
    @Published var productDescription: String = ""
    @Published var productImages: [UIImage]? = nil
    @Published var selectedProductImages: [PhotosPickerItem] = [] {
        didSet {
            convertProductPhotoPickerItemsToUIImages(selectedProductImages: selectedProductImages)
        }
    }
    @Published var products: [ProductModel] = []
    @Published var productSize: String = ""
    @Published var productSizeStock: String = ""
    @Published var categories: [CategoryModel] = []
    private var lastDocument: DocumentSnapshot?
    @Published var hasMore: Bool = true
    
    @Published var user: UserModel? = nil
    
    
    init() {
        getAuthenticatedUser()
        addSubscribers()
        getProductsWithPagination()
    }
    
    
    private func addSubscribers() {
//        FirestoreProductManager.shared.getProductsUsingListener()
//            .sink { [weak self] returnedProducts in
//                self?.products = returnedProducts
//            }
//            .store(in: &cancellables)
        
        FirestoreCategoryManager.shared.getCategoriesUsingLisitner()
            .sink { [weak self] returnedCategories in
                self?.categories = returnedCategories
                                
                if self?.productCategory == nil {
                    self?.productCategory = returnedCategories.first
                }
            }
            .store(in: &cancellables)
    }
    
    
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
    
    func getProductsWithPagination() {
        Task {
            do {
                let result = try await FirestoreProductManager.shared.getProductWithPagination(limit: 10, lastDocument: lastDocument)
                self.lastDocument = result.lastDocument
                self.products.append(contentsOf: result.products)
                self.hasMore = result.hasMore
            } catch {
                print(error)
            }
        }
    }
    
    private func getAuthenticatedUser() {
        guard let authedUser = Auth.auth().currentUser else {return}
        Task {
            do {
                self.user = try await FirestoreUserManager.shared.getUser(userId: authedUser.uid)
            } catch {
                print(error)
            }
        }
    }
    
    
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
    
}
