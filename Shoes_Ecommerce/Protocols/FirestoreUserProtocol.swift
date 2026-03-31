//
//  FirestoreUserProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 31/03/2026.
//

import Foundation
internal import Combine


protocol FirestoreUserProtocol {
    func saveUser(user: UserModel) async throws
    func getUserUsingLisitner(userId: String) -> AnyPublisher<UserModel, Never>
    func uploadImage(userId: String, image: ImageModel) async throws
    func getUser(userId: String) async throws -> UserModel?
}
