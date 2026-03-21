//
//  NameTextFieldItem.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct NameTextFieldItem: View {
    
    let placeholder: String
    @Binding var text: String
    let type: nameType
    
    var body: some View {
        TextField(placeholder.capitalized, text: $text)
            .asNameTextField(type: type)
    }
}

#Preview {
    NameTextFieldItem(placeholder: "first name", text: .constant(""), type: .first)
}
