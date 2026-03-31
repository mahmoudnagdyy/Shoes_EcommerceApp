//
//  FirestoreCategoryProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 31/03/2026.
//

import Foundation
internal import Combine


protocol FirestoreCategoryProtocol {
    func createCategory(categoryName: String, categoryImage: ImageModel) async throws
    func getCategoriesUsingLisitner() -> AnyPublisher<[CategoryModel], Never>
    func getCategory(categoryId: String) async throws -> CategoryModel
}
