//
//  DashboardViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import Foundation
internal import Combine
import _PhotosUI_SwiftUI
import FirebaseAuth

@MainActor
class DashboardViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    @Published var categoriesCount: Int = 0
    @Published var productsCount: Int = 0
    
    let firestoreProductManager: FirestoreProductProtocol
    let firestoreCategoryManager: FirestoreCategoryProtocol
    
    init(
        firestoreProductManager: FirestoreProductProtocol,
        firestoreCategoryManager: FirestoreCategoryProtocol
    ) {
        self.firestoreProductManager = firestoreProductManager
        self.firestoreCategoryManager = firestoreCategoryManager
        addSubsribers()
    }
    
    private func addSubsribers() {
        firestoreCategoryManager.getCategoriesUsingLisitner()
            .sink { [weak self] returnedCategories in
                self?.categoriesCount = returnedCategories.count
            }
            .store(in: &cancellables)
        
        
        firestoreProductManager.getProductsUsingListener()
            .sink { [weak self] returnedProducts in
                self?.productsCount = returnedProducts.count
            }
            .store(in: &cancellables)
    }
    
}
