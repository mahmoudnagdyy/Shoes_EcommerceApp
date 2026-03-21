//
//  AuthenticationManager.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
internal import Combine
import FirebaseAuth

class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    func signInWithGoogle() async throws {
        let authResult = try await SignInWithGoogleHelper.shared.signInWithGoogleSetup()
        let fName = authResult.user.displayName?.split(separator: " ").first ?? ""
        let lName = authResult.user.displayName?.split(separator: " ").last ?? ""
        let user = UserModel(
            id: authResult.user.uid,
            firstName: String(fName),
            lastName: String(lName),
            email: authResult.user.email ?? "",
            photoUrl: authResult.user.photoURL?.absoluteString
        )
        
        try await FirestoreUserManager.shared.saveUser(user: user)
    }
    
}


// MARK: SIGNUP
extension AuthenticationManager {
    
    func signUpWithEmailAndPassword(firstName: String, lastName: String, email: String, password: String) async throws {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = UserModel(
            id: authResult.user.uid,
            firstName: firstName,
            lastName: lastName,
            email: email,
            photoUrl: nil
        )
        try await FirestoreUserManager.shared.saveUser(user: user)
    }
    
}


// MARK: LOGIN
extension AuthenticationManager {
    
    func signInWithEmailAndPassword(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
}
