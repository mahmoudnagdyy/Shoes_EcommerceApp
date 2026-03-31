//
//  SignupView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct SignupView: View {
    
    @StateObject var vm: SignupViewModel
    let onLoginLinkPressed: () -> Void
    let onSignupButtonPressed: () -> Void
    
    init(onLoginLinkPressed: @escaping () -> Void, onSignupButtonPressed: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: SignupAuthHelper.makeSignupView())
        self.onLoginLinkPressed = onLoginLinkPressed
        self.onSignupButtonPressed = onSignupButtonPressed
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // background
            Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)).ignoresSafeArea()
            
            // foreground
            SignupForeground
        }
    }
}

#Preview {
    SignupView {
        
    } onSignupButtonPressed: {
        
    }

}


extension SignupView {
    
    private var SignupForeground: some View {
        VStack {
            CreateAnAccountText
            
            ZStack(alignment: .top) {
                // background
                signupFormBackground
                
                // foreground
                signupFormForeground
            }
            
        }
    }
    
    private var CreateAnAccountText: some View {
        Text("Create an account")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .fontWeight(.heavy)
            .frame(maxWidth: 200)
            .multilineTextAlignment(.center)
            .padding(30)
    }
    
    private var signupFormBackground: some View {
        Color.white
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 40, topTrailingRadius: 40))
            .ignoresSafeArea(edges: [.bottom])
    }
    
    private var signupFormForeground: some View {
        ScrollView(.vertical) {
            VStack {
                                
                googleSignInButton
                
                orSeparator
                
                nameTextFields
                
                EmailTextFieldItem(text: $vm.email)
                
                PasswordTextFieldItem(text: $vm.password)
                
                if let signupError = vm.signupError {
                    Text(signupError)
                        .foregroundStyle(.red)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                signupSubmitButton
                
                registerFooterItem
            }
            .padding(.vertical, 40)
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
    
    private var nameTextFields: some View {
        HStack {
            NameTextFieldItem(placeholder: "first name", text: $vm.firstName, type: .first)
            NameTextFieldItem(placeholder: "last name", text: $vm.lastName, type: .last)
        }
    }
    
    private var signupSubmitButton: some View {
        SubmitButton(text: "create account", bgColor: .black, fgColor: .white) {
            signupSubmitButtonFunction()
        }
    }
    
    private var registerFooterItem: some View {
        RegisterFooterItem(text: "Have an account?", linkText: "login here") {
            onLoginLinkPressed()
        }
    }
    
    private var orSeparator: some View {
        Text("or")
            .font(.headline)
            .foregroundStyle(.gray)
            .padding(.bottom)
    }
    
    private var googleSignInButton: some View {
        GoogleSignInButton {
            Task {
                do {
                    try await vm.signInWithGoogle()
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    onSignupButtonPressed()
                } catch {
                    print(error)
                }
            }
        }
    }
}




extension SignupView {
    
    private func signupSubmitButtonFunction() {
        Task {
            do {
                try await vm.signupWithEmailAndPassword(firstName: vm.firstName, lastName: vm.lastName, email: vm.email, password: vm.password)
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                onSignupButtonPressed()
            } catch {
                if vm.password.count < 6 {
                    vm.signupError = "The password must be 6 characters long or more."
                }
                else {
                    vm.signupError = "Email is already exist."
                }
                print(error)
            }
        }
    }
    
}



struct SignupAuthHelper {
    
    static func makeSignupView() -> SignupViewModel {
        let googleService: GoogleSignInServiceProtocol = SignInWithGoogleHelper()
        let firestoreUserManager: FirestoreUserProtocol = FirestoreUserManager()
        let authManager: AutheServiceProtocol = AuthenticationManager(googleService: googleService, firestoreUserManager: firestoreUserManager)
        return SignupViewModel(authManager: authManager)
    }
    
}
