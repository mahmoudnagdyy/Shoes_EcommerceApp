//
//  SignupView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct SignupView: View {
    
    @StateObject var vm = SignupViewModel()
    
    let onLoginLinkPressed: () -> Void
    
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
        VStack {
            
            // next: add google Signin Button
            
            nameTextFields
            
            EmailTextFieldItem(text: $vm.email)
            
            PasswordTextFieldItem(text: $vm.password)
            
            signupSubmitButton
            
            registerFooterItem
        }
        .padding(.vertical, 40)
        .padding(.horizontal)
    }
    
    private var nameTextFields: some View {
        HStack {
            NameTextFieldItem(placeholder: "first name", text: $vm.firstName, type: .first)
            NameTextFieldItem(placeholder: "last name", text: $vm.lastName, type: .last)
        }
    }
    
    private var signupSubmitButton: some View {
        SubmitButton(text: "create account", bgColor: .black) {
            // action
        }
    }
    
    private var registerFooterItem: some View {
        RegisterFooterItem(text: "Have an account?", linkText: "login here") {
            onLoginLinkPressed()
        }
    }
}
