//
//  TabViewContainer.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import SwiftUI

struct TabViewContainer<Content: View>: View {
    
    @Binding var selectedTab: TabModel
    let content: Content
    @State var allTabs: [TabModel] = []
    
    init(selectedTab: Binding<TabModel>, @ViewBuilder content: () -> Content) {
        self.content = content()
        _selectedTab = Binding(projectedValue: selectedTab)
    }
    
    var body: some View {
//        VStack(spacing: 0) {
//            ZStack {
//                content
//            }
//            allTabsView(allTabs: $allTabs, selectedTab: $selectedTab)
//        }
        ZStack(alignment: .bottom, content: {
            content
            allTabsView(allTabs: $allTabs, selectedTab: $selectedTab)
                .zIndex(2)
        })
        .onPreferenceChange(TabItemPreferenceKey.self) { value in
            allTabs = value
        }
    }
}

#Preview {
    TabViewContainer(selectedTab: .constant(TabModel(title: "", iconName: ""))) {
        
    }
}
