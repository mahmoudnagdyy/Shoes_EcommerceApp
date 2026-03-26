//
//  SubmitButtonViewModifier.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
import SwiftUI


struct SubmitButtonViewModifier: ViewModifier {
    
    let bgColor: Color
    let fgColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(bgColor)
            .clipShape(.capsule)
            .foregroundStyle(fgColor)
            .font(.title3)
            .bold()
            .padding(.vertical)
    }
}
