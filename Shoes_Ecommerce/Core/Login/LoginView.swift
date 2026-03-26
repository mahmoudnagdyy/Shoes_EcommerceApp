//
//  LoginView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var vm = LoginViewModel()
    
    let onSignupLinkPressed: () -> Void
    let onLoginButtonPressed: () -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            // background
            Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)).ignoresSafeArea()
            
            // foreground
            LoginForeground
        }
    }
}

#Preview {
    LoginView {
        
    } onLoginButtonPressed: {
        
    }

}


extension LoginView {
    
    private var LoginForeground: some View {
        VStack {
            loginHereText
            
            ZStack(alignment: .top) {
                // background
                loginFormBackground
                
                // foreground
                loginFormForeground
            }
            
        }
    }
    
    private var loginHereText: some View {
        Text("login in here".capitalized)
            .font(.largeTitle)
            .foregroundStyle(.white)
            .fontWeight(.heavy)
            .frame(maxWidth: 200)
            .multilineTextAlignment(.center)
            .padding(30)
    }
    
    private var loginFormBackground: some View {
        Color.white
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 40, topTrailingRadius: 40))
            .ignoresSafeArea(edges: [.bottom])
    }
    
    private var loginFormForeground: some View {
        ScrollView(.vertical) {
            VStack {
                
                googleSignInButton
                
                orSeparator
                
                EmailTextFieldItem(text: $vm.email)
                
                PasswordTextFieldItem(text: $vm.password)
                
                if let loginError = vm.loginError {
                    Text(loginError)
                        .foregroundColor(.red)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                loginSubmitButton
                
                registerFooterItem
            }
            .padding(.vertical, 40)
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
    
    private var loginSubmitButton: some View {
        SubmitButton(text: "log in", bgColor: .black, fgColor: .white) {
            loginSubmitButtonFunction()
        }
    }
    
    private var registerFooterItem: some View {
        RegisterFooterItem(text: "Don't have an account?", linkText: "signup here") {
            onSignupLinkPressed()
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
                    try await AuthenticationManager.shared.signInWithGoogle()
                    onLoginButtonPressed()
                } catch {
                    print(error)
                }
            }
        }
    }
    
}


extension LoginView {
    
    private func loginSubmitButtonFunction() {
        Task {
            do {
                try await AuthenticationManager.shared.signInWithEmailAndPassword(email: vm.email, password: vm.password)
                vm.email = ""
                vm.password = ""
                vm.loginError = nil
                onLoginButtonPressed()
            } catch {
                vm.loginError = "Email or password is incorrect."
                print(error)
            }
        }
    }
    
}
