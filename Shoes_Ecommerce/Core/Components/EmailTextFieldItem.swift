//
//  EmailTextFieldItem.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct EmailTextFieldItem: View {
    
    @Binding var text: String
    
    var body: some View {
        TextField("email".capitalized, text: $text)
            .asTextField()
            .clipShape(.capsule)
    }
}

#Preview {
    EmailTextFieldItem(text: .constant(""))
}
