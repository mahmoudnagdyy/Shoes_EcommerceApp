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
    
}
