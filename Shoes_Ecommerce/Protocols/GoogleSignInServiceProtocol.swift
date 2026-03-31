//
//  GoogleSignInServiceProtocol.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 31/03/2026.
//

import Foundation
import FirebaseAuth


protocol GoogleSignInServiceProtocol {
    func signInWithGoogleSetup() async throws -> AuthDataResult
}
