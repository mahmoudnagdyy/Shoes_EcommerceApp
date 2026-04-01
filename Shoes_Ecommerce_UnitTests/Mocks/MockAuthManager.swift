//
//  MockAuthManager.swift
//  Shoes_EcommerceTests
//
//  Created by Mahmoud Nagdy on 01/04/2026.
//

import Foundation
@testable import Shoes_Ecommerce

final class MockAuthManager: AutheServiceProtocol {
    
    var shouldThrowError = false
    
    func signInWithEmailAndPassword(email: String, password: String) async throws {
        if shouldThrowError {
            throw URLError(.badURL)
        }
    }
    
    func signInWithGoogle() async throws {
        
    }
    
    func logout() throws {
        
    }
    
    func signUpWithEmailAndPassword(firstName: String, lastName: String, email: String, password: String) async throws {
        if shouldThrowError {
            throw URLError(.badURL)
        }
    }
    
    
}
