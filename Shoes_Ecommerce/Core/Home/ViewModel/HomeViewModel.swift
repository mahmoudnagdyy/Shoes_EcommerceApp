//
//  HomeViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import Foundation
internal import Combine
import FirebaseAuth

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var user: UserModel? = nil
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getUser()
    }
    
    func getUser() {
        guard let authedUser = Auth.auth().currentUser else { return }
        FirestoreUserManager.shared.getUserUsingLisitner(userId: authedUser.uid)
            .sink { [weak self] returnedUser in
                self?.user = returnedUser
            }
            .store(in: &cancellables)
    }
    
}
