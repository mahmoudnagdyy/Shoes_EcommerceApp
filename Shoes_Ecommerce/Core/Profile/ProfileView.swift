//
//  ProfileView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm: ProfileViewModel
    let onLogoutButtonPressed: () -> Void
    @State var showDashboard: Bool = false
    
    init(onLogoutButtonPressed: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: ProfileHelper.makeProfileView())
        self.onLogoutButtonPressed = onLogoutButtonPressed
    }
    
    var body: some View {
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            profileForegroundContainer
        }
    }
}

#Preview {
    ProfileView {
        
    }
}


extension ProfileView {
    
    private var profileForegroundContainer: some View {
        ScrollView(.vertical) {
            VStack {
                
                logoutButton
                
                if let image = vm.user?.image,
                   !image.secureUrl.isEmpty {
                    UserPhotoPickerItemView(imageLink: image.secureUrl,
                                        showChangeImageCover: $vm.showChangeImageCover)
                }
                else if let photoUrl = vm.user?.photoUrl,
                        !photoUrl.isEmpty {
                    UserPhotoPickerItemView(imageLink: photoUrl,
                                        showChangeImageCover: $vm.showChangeImageCover)
                } else {
                    noUserImagePhotoPicker 
                }
                
                displayUserName()
                
                ProfileItemView(text: vm.user?.email ?? "no email", iconName: "envelope.fill")
                
                if let user = vm.user, user.role == UserType.admin.rawValue {
                    ProfileItemView(text: "dashboard".capitalized, iconName:"square.grid.2x2")
                        .onTapGesture {
                            showDashboard.toggle()
                        }
                        .fullScreenCover(isPresented: $showDashboard) {
                            DashboardView()
                        }
                }
                
            }
            .padding()
            .fullScreenCover(isPresented: $vm.showChangeImageCover) {
                UploadUserImageView(vm: vm)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var noUserImage: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .overlay {
                Circle()
                    .stroke(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)), lineWidth: 3)
            }
    }
    
    private var logoutButton: some View {
        Button {
            do {
                try vm.logout()
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                onLogoutButtonPressed()
            } catch {
                print(error)
            }
        } label: {
            Image(systemName: "iphone.and.arrow.forward.outward")
                .frame(width: 55, height: 55)
                .background(.white)
                .clipShape(.circle)
                .padding()
                .foregroundStyle(.red)
                .font(.title)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var noUserImagePhotoPicker: some View {
        ZStack(alignment: .bottomTrailing) {
            noUserImage
            Image(systemName: "pencil.circle.fill")
                .font(.title)
                .offset(x: 18, y: 10)
                .onTapGesture {
                    vm.showChangeImageCover.toggle()
                }
        }
    }
    
}


extension ProfileView {
    
    private func displayUserName() -> some View {
        let firstName = vm.user?.firstName ?? "fName"
        let lastName = vm.user?.lastName ?? "lName"
        return Text("\(firstName) \(lastName)".capitalized).font(.largeTitle).bold()
    }
    
}



struct ProfileHelper {
    
    static func makeProfileView() -> ProfileViewModel {
        let googleService: GoogleSignInServiceProtocol = SignInWithGoogleHelper()
        let firestoreUserManager: FirestoreUserProtocol = FirestoreUserManager()
        let authManager: AutheServiceProtocol = AuthenticationManager(googleService: googleService, firestoreUserManager: firestoreUserManager)
        let uploadPhotoService: UploadUserPhotoServiceProtocol = UserService()
        return ProfileViewModel(
            authManager: authManager,
            firestoreUserManager: firestoreUserManager,
            uploadPhotoService: uploadPhotoService)
    }
    
}
