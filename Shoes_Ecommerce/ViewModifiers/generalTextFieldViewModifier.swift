//
//  generalTextFieldViewModifier.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
import SwiftUI


struct generalTextFieldViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(height: 60)
            .padding(.horizontal)
            .background(.gray.opacity(0.1))
            .font(.headline)
    }
    
}
