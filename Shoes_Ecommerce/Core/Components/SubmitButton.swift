//
//  SubmitButton.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct SubmitButton: View {
    
    let text: String
    let bgColor: Color
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text.capitalized)
                .asSubmitButton(bgColor: bgColor)
        }
    }
}

#Preview {
    SubmitButton(text: "submit", bgColor: .red) {
        
    }
}
