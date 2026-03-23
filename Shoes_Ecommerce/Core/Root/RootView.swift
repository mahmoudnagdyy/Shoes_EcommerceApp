//
//  RootView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: TabModel = TabModel(title: "home", iconName: "house.fill")
    let onLogoutButtonPressed: () -> Void
    
    var body: some View {
        
        TabViewContainer(selectedTab: $selectedTab) {
            HomeView()
                .tabItem(tab: TabModel(title: "home", iconName: "house.fill"), selectedTab: selectedTab)
            
            Rectangle()
                .fill(Color.yellow)
                .tabItem(tab: TabModel(title: "cart", iconName: "handbag.fill"), selectedTab: selectedTab)
            
            Rectangle() 
                .fill(Color.orange)
                .tabItem(tab: TabModel(title: "favorites", iconName: "heart.fill"), selectedTab: selectedTab)
            
            DashboardView()
                .tabItem(tab: TabModel(title: "dashboard", iconName: "square.grid.2x2"), selectedTab: selectedTab)
            
            ProfileView(onLogoutButtonPressed: {
                onLogoutButtonPressed()
            })
            .tabItem(tab: TabModel(title: "profile", iconName: "person.fill"), selectedTab: selectedTab)
        }
        
    }
}

#Preview {
    RootView {
        
    }
}
