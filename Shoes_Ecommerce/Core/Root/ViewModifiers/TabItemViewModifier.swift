//
//  TabItemViewModifier.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import Foundation
import SwiftUI


struct TabItemViewModifier: ViewModifier {
    
    let tab: TabModel
    let selectedTab: TabModel
    
    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tab])
            .opacity(selectedTab == tab ? 1 : 0)
    }
    
}
