//
//  UploadUserImageView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import SwiftUI
import PhotosUI


struct UploadUserImageView: View {
    
    @ObservedObject var vm: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            ScrollView(.vertical) {
                VStack {
                    XButtonView {
                        dismiss()
                    }
                    
                    userUploadPhotoPicker
                    
                    UploadPhotoButton
                    
                    if vm.isLoading {
                        ProgressView()
                            .tint(.black)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    
    let googleService: GoogleSignInServiceProtocol = SignInWithGoogleHelper()
    let firestoreUserManager: FirestoreUserProtocol = FirestoreUserManager()
    let authManager: AutheServiceProtocol = AuthenticationManager(googleService: googleService, firestoreUserManager: firestoreUserManager)
    
    UploadUserImageView(vm: ProfileViewModel(authManager: authManager, firestoreUserManager: firestoreUserManager, uploadPhotoService: UserService()))
}



extension UploadUserImageView {
    
    private var userUploadPhotoPicker: some View {
        
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .clipShape(.circle)
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                }
            }
            .frame(width: 200, height: 200)
            .overlay {
                Circle()
                    .stroke(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)), lineWidth: 5)
            }
            
            PhotosPicker(selection: $vm.selectedImage) {
                Image(systemName: "camera.fill")
                    .foregroundStyle(.black)
                    .font(.title)
                    .offset(x: 25, y: 10)
            }
            
        }
        .padding(.vertical, 50)
    }
    
    private var UploadPhotoButton: some View {
        SubmitButton(text: "save", bgColor: .black, fgColor: .white) {
            uploadImageButtonFunction()
        }
        .disabled(vm.isLoading)
        .opacity(vm.isLoading ? 0.4 : 1)
    }
    
}



extension UploadUserImageView {
    
    private func uploadImageButtonFunction() {
        Task {
            do {
                vm.isLoading = true
                try await vm.uploadImage()
                vm.isLoading = false
                vm.selectedImage = nil
                vm.image = nil
                dismiss()
            } catch {
                vm.isLoading = false
                print(error)
            }
        }
    }
    
}
