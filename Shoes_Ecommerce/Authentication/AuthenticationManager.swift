//
//  AuthenticationManager.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
internal import Combine
import FirebaseAuth

class AuthenticationManager: AutheServiceProtocol {
    
    let googleService: GoogleSignInServiceProtocol
    let firestoreUserManager: FirestoreUserProtocol
    
    init(googleService: GoogleSignInServiceProtocol, firestoreUserManager: FirestoreUserProtocol) {
        self.googleService = googleService
        self.firestoreUserManager = firestoreUserManager
    }
    
    func signInWithGoogle() async throws {
        let authResult = try await googleService.signInWithGoogleSetup()
        let fName = authResult.user.displayName?.split(separator: " ").first ?? ""
        let lName = authResult.user.displayName?.split(separator: " ").last ?? ""
        let user = UserModel(
            id: authResult.user.uid,
            firstName: String(fName),
            lastName: String(lName),
            email: authResult.user.email ?? "",
            photoUrl: authResult.user.photoURL?.absoluteString,
            image: nil
        )
        
        try await firestoreUserManager.saveUser(user: user)
    }
    
    
    func logout() throws {
        try Auth.auth().signOut()
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
            photoUrl: nil,
            image: nil
        )
        try await firestoreUserManager.saveUser(user: user)
    }
    
}


// MARK: LOGIN
extension AuthenticationManager {
    
    func signInWithEmailAndPassword(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
}
