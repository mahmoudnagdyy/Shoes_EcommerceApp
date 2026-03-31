//
//  RootViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import Foundation
internal import Combine
import FirebaseAuth


@MainActor
class RootViewModel: ObservableObject {
    
    @Published var user: UserModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    let firestoreUserManager: FirestoreUserProtocol
    
    init(firestoreUserManager: FirestoreUserProtocol) {
        self.firestoreUserManager = firestoreUserManager
        getAuthenticatedUser()
    }
    
    func getAuthenticatedUser() {
        guard let authedUser = Auth.auth().currentUser else {return}
        
        Task {
            do {
                self.user = try await firestoreUserManager.getUser(userId: authedUser.uid)
            } catch {
                print(error)
            }
        }
    }
    
}
