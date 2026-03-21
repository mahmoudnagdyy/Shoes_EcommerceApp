//
//  ContentView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct ContentView: View {
    
    enum allScreens {
        case signup, login
    }
    
    @State var currentScreen: allScreens = .login
    
    var body: some View {
        ZStack { 
            switch currentScreen {
            case .login:
                loginView
            case .signup:
                signupView
            }
            
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    
    private var loginView: some View {
        LoginView(onSignupLinkPressed: {
            onSignupLinkPressed()
        })
        .transition(.move(edge: .leading))
    }
    
    private var signupView: some View {
        SignupView {
            onloginLinkPressed()
        }
        .transition(.move(edge: .trailing))
    }
    
}


extension ContentView {
    
    private func onSignupLinkPressed() {
        withAnimation {
            currentScreen = .signup
        }
    }
    
    private func onloginLinkPressed() {
        withAnimation {
            currentScreen = .login
        }
    }
    
}
