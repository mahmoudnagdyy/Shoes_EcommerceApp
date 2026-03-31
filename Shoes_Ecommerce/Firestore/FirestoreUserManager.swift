//
//  FirestoreUserManager.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
internal import Combine
import FirebaseFirestore

class FirestoreUserManager: FirestoreUserProtocol {
        
    private let userCollection = Firestore.firestore().collection("users")
        
    private func userDocument(userID: String) -> DocumentReference {
        userCollection.document(userID)
    }
    
    func saveUser(user: UserModel) async throws {
        try await userDocument(userID: user.id).setData(user.userDict, merge: true)
    }
    
    func getUserUsingLisitner(userId: String) -> AnyPublisher<UserModel, Never> {
        let publisher = PassthroughSubject<UserModel, Never>()
        userDocument(userID: userId).addSnapshotListener { snapshot, error in
            guard let snapshot, error == nil else {return}
            do {
                let user = try snapshot.data(as: UserModel.self)
                publisher.send(user)
            } catch {
                print(error)
            }
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func uploadImage(userId: String, image: ImageModel) async throws {
        let imageDict: [String: Any] = [
            ImageModel.CodingKeys.publicId.rawValue: image.publicId,
            ImageModel.CodingKeys.secureUrl.rawValue: image.secureUrl
        ]
        try await userDocument(userID: userId).setData(["image": imageDict], merge: true)
    }
    
    func getUser(userId: String) async throws -> UserModel? {
        return try? await userDocument(userID: userId).getDocument(as: UserModel.self)
    }
    
}
