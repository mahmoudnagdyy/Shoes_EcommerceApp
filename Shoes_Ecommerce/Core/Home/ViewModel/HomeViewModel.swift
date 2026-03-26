//
//  HomeViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import Foundation
internal import Combine
import FirebaseAuth

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var user: UserModel? = nil
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    @Published var categories: [CategoryModel] = []
    @Published var selectedCategory: CategoryModel? = nil {
        didSet {
            filteredProducts = allProducts.filter({$0.categoryId == selectedCategory?.id})
        }
    }
    @Published var allProducts: [ProductModel] = [] {
        didSet {
            filteredProducts = allProducts.filter({$0.categoryId == selectedCategory?.id})
        }
    }
    @Published var filteredProducts: [ProductModel] = []
    @Published var searchResults: [ProductModel] = []
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        getUser()
        getCategories()
        getAllProducts()
        getSearchResults()
    }
    
    private func getUser() {
        guard let authedUser = Auth.auth().currentUser else { return }
        FirestoreUserManager.shared.getUserUsingLisitner(userId: authedUser.uid)
            .sink { [weak self] returnedUser in
                self?.user = returnedUser
            }
            .store(in: &cancellables)
    }
    
    private func getCategories() {
        FirestoreCategoryManager.shared.getCategoriesUsingLisitner()
            .sink { [weak self] returnedCategories in
                self?.categories = returnedCategories
                self?.selectedCategory = returnedCategories.first
            }
            .store(in: &cancellables)
    }
    
    private func getAllProducts() {
        FirestoreProductManager.shared.getProductsUsingListener()
            .sink { [weak self] returnedProducts in
                self?.allProducts = returnedProducts
            }
            .store(in: &cancellables)
    }
    
    private func getSearchResults() {
        $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .tryMap { text in
                let result = self.allProducts.filter { product in
                    return product.productName.lowercased().contains(text.lowercased())
                }
                return result
            }
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] returnedProducts in
                self?.searchResults = returnedProducts
            }
            .store(in: &cancellables)
    }
    
}
