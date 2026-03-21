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
            .cornerRadius(40)
            .ignoresSafeArea()
    }
    
    private var loginFormForeground: some View {
        VStack {
            
            // next: add google Signin Button
    
            EmailTextFieldItem(text: $vm.email)
            
            PasswordTextFieldItem(text: $vm.password)
            
            loginSubmitButton
            
            registerFooterItem
        }
        .padding(.vertical, 40)
        .padding(.horizontal)
    }
    
    private var loginSubmitButton: some View {
        SubmitButton(text: "log in", bgColor: .black) {
            // action
        }
    }
    
    private var registerFooterItem: some View {
        RegisterFooterItem(text: "Don't have an account?", linkText: "signup here") {
            onSignupLinkPressed()
        }
    }
    
}
