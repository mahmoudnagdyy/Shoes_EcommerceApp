//
//  RootView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 21/03/2026.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var vm = RootViewModel(firestoreUserManager: FirestoreUserManager())
    @State var selectedTab: TabModel = TabModel(title: "home", iconName: "house.fill")
    let onLogoutButtonPressed: () -> Void
    
    var body: some View {
        
        TabViewContainer(selectedTab: $selectedTab) {
            HomeView()
                .tabItem(tab: TabModel(title: "home", iconName: "house.fill"), selectedTab: selectedTab)
                
            
            FavoritesView()
                .tabItem(tab: TabModel(title: "favorites", iconName: "heart.fill"), selectedTab: selectedTab)
            
            CartView()
                .tabItem(tab: TabModel(title: "cart", iconName: "handbag.fill"), selectedTab: selectedTab)
            
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
