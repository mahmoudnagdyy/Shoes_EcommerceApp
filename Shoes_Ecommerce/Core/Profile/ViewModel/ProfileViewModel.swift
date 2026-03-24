//
//  ProfileViewModel.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import Foundation
internal import Combine
import FirebaseAuth
import _PhotosUI_SwiftUI


@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published var user: UserModel?
    var cancellables = Set<AnyCancellable>()
    @Published var showChangeImageCover: Bool = false
    @Published var image: UIImage?
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                do {
                    let imageData = try await selectedImage?.loadTransferable(type: Data.self)
                    if let imageData {
                        image = UIImage(data: imageData)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    @Published var isLoading: Bool = false
    
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
    
    func uploadImage() async throws {
        guard let user, let image else { return }
        let returnedImage = try await UserService.shared.uploadPhoto(userId: user.id, image: image)
        try await FirestoreUserManager.shared.uploadImage(userId: user.id, image: returnedImage)
    }
    
}
