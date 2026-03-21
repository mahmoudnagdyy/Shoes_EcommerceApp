//
//  GoogleSignInButton.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct GoogleSignInButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            googleSignInButtonLabel
        }
            
    }
}

#Preview {
    GoogleSignInButton {
        
    }
}


extension GoogleSignInButton {
    
    private var googleSignInButtonLabel: some View {
        HStack {
            Image("google_icon")
                .resizable()
                .frame(width: 25, height: 25)
            Text("sign in with google".capitalized)
                .foregroundStyle(.black)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .clipShape(.capsule)
        .overlay {
            Capsule()
                .stroke(.gray.opacity(0.2), lineWidth: 2)
        }
        .padding(.vertical)
    }
    
}
