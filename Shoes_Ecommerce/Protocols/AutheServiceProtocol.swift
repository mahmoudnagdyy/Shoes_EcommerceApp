//
//  AuthServiceProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 31/03/2026.
//

import Foundation



protocol AutheServiceProtocol {
    func signInWithGoogle() async throws
    func logout() throws
    func signUpWithEmailAndPassword(firstName: String, lastName: String, email: String, password: String) async throws
    func signInWithEmailAndPassword(email: String, password: String) async throws
}
