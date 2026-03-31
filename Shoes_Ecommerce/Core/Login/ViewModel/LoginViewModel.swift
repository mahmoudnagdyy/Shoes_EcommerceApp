//
//  LoginViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
internal import Combine


@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var loginError: String? = nil
    
    let authManager: AutheServiceProtocol
    
    init(authManager: AutheServiceProtocol) {
        self.authManager = authManager
    }
    
    func loginWithEmailAndPassword(email: String, password: String) async throws {
        try await authManager.signInWithEmailAndPassword(email: email, password: password)
        self.email = ""
        self.password = ""
        self.loginError = nil
    }
    
    func signInWithGoogle() async throws {
        try await authManager.signInWithGoogle()
    }
}
