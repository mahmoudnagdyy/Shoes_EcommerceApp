//
//  ProfileItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import SwiftUI

struct ProfileItemView: View {
    
    let text: String
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundStyle(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)))
                .font(.title3)
            Text(text)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 60)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
        }
    }
}

#Preview {
    ProfileItemView(text: "mahmoudnagdy65@gmail.com", iconName: "envelope.fill")
}
