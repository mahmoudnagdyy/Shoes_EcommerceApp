//
//  CategoryViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import Foundation
internal import Combine
import SwiftUI
import PhotosUI

@MainActor
class CategoryViewModel: ObservableObject {
    
    @Published var Categoryimage: UIImage?
    @Published var selectedCategoryImage: PhotosPickerItem? {
        didSet {
            convertCategoryPhotoPickerToUIImage(selectedCategoryImage: selectedCategoryImage)
        }
    }
    @Published var categoryName: String = ""
    @Published var categories: [CategoryModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let firestoreCategoryManager: FirestoreCategoryProtocol
    
    
    init(
        firestoreCategoryManager: FirestoreCategoryProtocol
    ) {
        self.firestoreCategoryManager = firestoreCategoryManager
        getCategories()
    }
    
    
    func createCategory() async throws {
        guard let Categoryimage, !categoryName.isEmpty else {return}
        let returnedImage = try await CategoryService.shared.uploadCategoryPhoto(categoryName: categoryName, image: Categoryimage)
        try await firestoreCategoryManager.createCategory(categoryName: categoryName, categoryImage: returnedImage)
    }
    
    func getCategories() {
        firestoreCategoryManager.getCategoriesUsingLisitner()
            .sink { [weak self] returnedCategories in
                self?.categories = returnedCategories
            }
            .store(in: &cancellables)
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
