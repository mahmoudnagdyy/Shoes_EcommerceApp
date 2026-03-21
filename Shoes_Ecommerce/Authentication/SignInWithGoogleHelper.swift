//
//  SignInWithGoogleHelper.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
internal import Combine
import GoogleSignIn
import GoogleSignInSwift
import UIKit
import FirebaseAuth


extension UIApplication {
    
    var topViewController: UIViewController? {
        
        let keyWindow = connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        
        var top = keyWindow?.rootViewController
        
        while let presented = top?.presentedViewController {
            top = presented
        }
        
        return top
    }
}

struct Tokens {
    let accessToken: String
    let idToken: String
}


enum SignInWithGoogleError: Error, LocalizedError {
    case noTopVC
    case noIDToken
    
    var errorDescription: String {
        switch self {
        case .noTopVC:
            return "No top view controller"
        case .noIDToken:
            return "No ID token"
        }
    }
}


class SignInWithGoogleHelper {
    
    static let shared = SignInWithGoogleHelper()
    
    private init() {}
    
    
    func signInWithGoogleSetup() async throws -> AuthDataResult {
        guard let topVC = UIApplication.shared.topViewController else {
            throw SignInWithGoogleError.noTopVC
        }
        let authResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken = authResult.user.idToken?.tokenString else {
            throw SignInWithGoogleError.noIDToken
        }
        let accessToken = authResult.user.accessToken.tokenString
        let tokens = Tokens(accessToken: accessToken, idToken: idToken)
        let credential = try await getGoogleCredentials(tokens: tokens)
        return try await Auth.auth().signIn(with: credential)
    }
    
    private func getGoogleCredentials(tokens: Tokens) async throws -> AuthCredential {
        return GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
    }
    
    
}
