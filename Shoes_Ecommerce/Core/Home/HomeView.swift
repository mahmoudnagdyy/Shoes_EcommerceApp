//
//  HomeView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    @StateObject var favVm = FavoritesViewModel()
    
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                // background
                Color.mainBg.ignoresSafeArea()
                
                // foreground
                homeForegroundContainer
            }
        }
    }
}

#Preview {
    HomeView()
}


extension HomeView {
    
    private var homeForegroundContainer: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                homeHeaderContainer
                
                searchBar
                
                if vm.searchText.isEmpty {
                    VStack(alignment: .leading) {
                        Text("categories".capitalized)
                            .font(.title)
                            .bold()
                        
                        categoriesScrollView
                        
                        categoryProductsScrollView
                    }
                    .transition(.scale(scale: 0, anchor: .topTrailing))
                    
                } else{
                    if !vm.searchResults.isEmpty {
                        searchResultProductsScrollView
                    } else{
                        VStack {
                            LottieView(name: "NoDataFound")
                                .frame(width: 300, height: 300)
                            Text("no results".capitalized)
                                .font(.title)
                                .bold()
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                    }
                }

            }
            .animation(.spring(duration: 0.5), value: vm.searchText)
            .padding()
        }
        .scrollIndicators(.hidden)
        .padding(.bottom, 100)
    }
    
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
                UserWebImageItem(imageUrl: image.secureUrl, width: 60, height: 60)
            }
            else if let photoUrl = vm.user?.photoUrl {
                UserWebImageItem(imageUrl: photoUrl, width: 60, height: 60)
            } else {
                noUserImageIcon
            }
            
        }
    }
    
    private var noUserImageIcon: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .frame(width: 60, height: 60)
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
    
    private var categoriesScrollView: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(vm.categories) { category in
                    HomeCategoryItemView(category: category, selectedCategory: $vm.selectedCategory)
                }
            }
        }
    }
    
    private var categoryProductsScrollView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(vm.filteredProducts) { product in
                    NavigationLink {
                        ProductSatckView(product: product, favVm: favVm)
                    } label: {
                        ProductItemView(product: product, favVm: favVm)
                    }
                }
            }
        }
        .padding(.vertical, 20)
    }
    
    private var searchResultProductsScrollView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(vm.searchResults) { product in
                    NavigationLink {
                        ProductSatckView(product: product, favVm: favVm)
                    } label: {
                        ProductItemView(product: product, favVm: favVm)
                    }
                }
            }
        }
        .transition(.opacity)
    }
    
}
