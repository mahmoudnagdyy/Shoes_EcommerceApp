//
//  SignupViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
internal import Combine

@MainActor
class SignupViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var signupError: String? = nil
    
    let authManager: AutheServiceProtocol
    
    init(authManager: AutheServiceProtocol) {
        self.authManager = authManager
    }
    
    
    func signupWithEmailAndPassword(firstName: String, lastName: String, email: String, password: String) async throws {
        try await authManager.signUpWithEmailAndPassword(firstName: firstName, lastName: lastName, email: email, password: password)
        
        self.firstName = ""
        self.email = ""
        self.lastName = ""
        self.password = ""
        self.signupError = nil
    }
    
    func signInWithGoogle() async throws {
        try await authManager.signInWithGoogle()
    }
    
}
