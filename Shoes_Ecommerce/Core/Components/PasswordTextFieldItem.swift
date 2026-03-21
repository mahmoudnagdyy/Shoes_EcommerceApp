//
//  PasswordTextFieldItem.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct PasswordTextFieldItem: View {
    
    @Binding var text: String
    @State var showPassword: Bool = false
    
    var body: some View {
        HStack {
            if showPassword {
                plainPasswordTextField
            } else {
                securePasswordTextField
            }
            
            eyeIcon
        }
        .font(.headline)
    }
}

#Preview {
    PasswordTextFieldItem(text: .constant(""))
}


extension PasswordTextFieldItem {
    
    private var eyeIcon: some View {
        Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
            .frame(width: 60, height: 60)
            .background(.gray.opacity(0.1))
            .clipShape(UnevenRoundedRectangle(bottomTrailingRadius: 30, topTrailingRadius: 30))
            .onTapGesture {
                showPassword.toggle()
            }
    }
    
    private var plainPasswordTextField: some View {
        TextField("password".capitalized, text: $text)
            .asTextField()
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 30))
    }
    
    private var securePasswordTextField: some View {
        SecureField("password".capitalized, text: $text)
            .asTextField()
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 30))
    }
    
}
