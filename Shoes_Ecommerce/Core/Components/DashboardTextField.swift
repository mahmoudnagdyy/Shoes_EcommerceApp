//
//  DashboardTextField.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import SwiftUI

struct DashboardTextField: View {
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        TextField(title.capitalized, text: $text)
            .frame(height: 60)
            .padding(.horizontal)
            .background(.white)
            .clipShape(.capsule)
            .font(.headline)
    }
}

#Preview {
    ZStack {
        Color.mainBg.ignoresSafeArea()
        
        DashboardTextField(title: "product name", text: .constant(""))
    }
}
