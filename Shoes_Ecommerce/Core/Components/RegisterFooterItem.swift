//
//  RegisterFooterItem.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct RegisterFooterItem: View {
    
    let text: String
    let linkText: String
    let action: () -> ()
    
    var body: some View {
        HStack {
            Text(text)
                .font(.headline)
            Text(linkText.capitalized)
                .bold()
                .underline()
                .onTapGesture {
                    action()
                }
        }
    }
}

#Preview {
    RegisterFooterItem(text: "", linkText: "") {
        
    }
}
