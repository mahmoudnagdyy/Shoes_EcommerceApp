//
//  HomeView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            homeForegroundContainer
        }
    }
}

#Preview {
    HomeView()
}


extension HomeView {
    
    private var homeHeaderText: some View {
        VStack(alignment: .leading) {
            Text("welcome back".capitalized)
                .foregroundStyle(.secondary)
            Text(vm.user?.firstName.capitalized ?? "no user")
                .font(.title3)
                .bold()
        }
    }
    
    private var homeHeaderContainer: some View {
        HStack {
            homeHeaderText
            Spacer()
            
            if let image = vm.user?.image {
                UserWebImageItem(imageUrl: image.secureUrl, width: 50, height: 50)
            }
            else if let photoUrl = vm.user?.photoUrl {
                UserWebImageItem(imageUrl: photoUrl, width: 50, height: 50)
            } else {
                noUserImageIcon
            }
                        
            
        }
    }
    
    private var noUserImageIcon: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .frame(width: 50, height: 50)
            .overlay {
                Circle()
                    .stroke(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)), lineWidth: 3)
            }
    }
    
    private var searchBar: some View {
        HStack {
            TextField("find shoes".capitalized, text: $vm.searchText)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .padding(.horizontal)
                .font(.headline)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 2)
                }
            
            Image(systemName: "magnifyingglass")
                .frame(width: 60, height: 60)
                .background(.black)
                .foregroundStyle(.white)
                .cornerRadius(15)
                .font(.headline)
        }
        .padding(.vertical)
    }
    
    private var homeForegroundContainer: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                homeHeaderContainer
                
                searchBar
                
                Text("categories".capitalized)
                    .font(.title)
                    .bold()
                
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
    
}
