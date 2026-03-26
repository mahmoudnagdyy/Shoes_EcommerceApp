//
//  View.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import Foundation
import SwiftUI


extension View {
    
    func asTextField() -> some View {
        modifier(generalTextFieldViewModifier())
    }
    
    func asNameTextField(type: nameType) -> some View {
        modifier(NameTextFieldViewModifier(type: type))
    }
    
    func asSubmitButton(bgColor: Color, fgColor: Color) -> some View {
        modifier(SubmitButtonViewModifier(bgColor: bgColor, fgColor: fgColor))
    }
    
    func tabItem(tab: TabModel, selectedTab: TabModel) -> some View {
        modifier(TabItemViewModifier(tab: tab, selectedTab: selectedTab))
    }
    
}
