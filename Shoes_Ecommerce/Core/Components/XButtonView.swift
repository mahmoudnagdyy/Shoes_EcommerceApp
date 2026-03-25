//
//  XButtonView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import SwiftUI

struct XButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        Image(systemName: "xmark")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    XButtonView {
        
    }
}
