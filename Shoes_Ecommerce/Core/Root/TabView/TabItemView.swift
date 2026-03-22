//
//  TabItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import SwiftUI

struct TabItemView: View {
    
    let tab: TabModel
    
    var body: some View {
        VStack {
            Image(systemName: tab.iconName)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
    }
}

#Preview {
    TabItemView(tab: TabModel(title: "home", iconName: "house.fill"))
}
