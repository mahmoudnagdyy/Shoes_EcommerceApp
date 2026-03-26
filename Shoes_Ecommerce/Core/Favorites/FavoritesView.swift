//
//  FavoritesView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject var vm = FavoritesViewModel()
    
    var body: some View {
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.favoriteProducts) { product in
                            NavigationLink {
                                ProductSatckView(product: product, favVm: vm)
                            } label: {
                                FavoriteItemView(product: product, favVm: vm)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 150)
                }
                .navigationTitle("wish list".capitalized)
            }
        }
    }
}

#Preview {
    FavoritesView()
}


extension FavoritesView {
    
    private func isProductFavorite(product: ProductModel) -> Bool {
        vm.favoriteProducts.contains(where: { $0.id == product.id })
    }
    
}
