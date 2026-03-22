//
//  FirestoreUserManager.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
internal import Combine
import FirebaseFirestore

class FirestoreUserManager {
    
    static let shared = FirestoreUserManager()
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private init() {}
    
    private func userDocument(userID: String) -> DocumentReference {
        userCollection.document(userID)
    }
    
    func saveUser(user: UserModel) async throws {
        try await userDocument(userID: user.id).setData(user.userDict)
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
    
}
