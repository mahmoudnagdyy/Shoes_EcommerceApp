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
    
    // MARK: CATEGORIES
    
    @Published var image: UIImage?
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                do {
                    let imageData = try await selectedImage?.loadTransferable(type: Data.self)
                    if let imageData {
                        image = UIImage(data: imageData)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    @Published var categoryName: String = ""
    @Published var categories: [CategoryModel] = []
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        getCategories()
    }
    
    
    func createCategory() async throws {
        guard let image, !categoryName.isEmpty else {return}
        let returnedImage = try await UploadCategoryPhotoService.shared.uploadCategoryPhoto(categoryName: categoryName, image: image)
        try await FirestoreCategoryManager.shared.createCategory(categoryName: categoryName, categoryImage: returnedImage)
    }
    
    func getCategories() {
        FirestoreCategoryManager.shared.getCategoriesUsingLisitner()
            .sink { [weak self] returnedCategories in
                self?.categories = returnedCategories
            }
            .store(in: &cancellables)
    }
    
}
