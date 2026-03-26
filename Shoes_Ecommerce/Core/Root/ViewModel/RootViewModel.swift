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
    
    init() {
        getAuthenticatedUser()
    }
    
    func getAuthenticatedUser() {
        guard let authedUser = Auth.auth().currentUser else {return}
        
        Task {
            do {
                self.user = try await FirestoreUserManager.shared.getUser(userId: authedUser.uid)
            } catch {
                print(error)
            }
        }
    }
    
}
