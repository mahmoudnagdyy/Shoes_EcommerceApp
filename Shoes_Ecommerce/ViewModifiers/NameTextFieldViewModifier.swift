//
//  NameTextFieldViewModifier.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
import SwiftUI


struct NameTextFieldViewModifier: ViewModifier {
    
    let type: nameType
    
    func body(content: Content) -> some View {
        content
            .asTextField()
            .clipShape(
                type == .first ?
                UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 30) :
                UnevenRoundedRectangle(bottomTrailingRadius: 30, topTrailingRadius: 30)
            )
    }
}
