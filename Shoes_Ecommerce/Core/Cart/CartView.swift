//
//  CartView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 26/03/2026.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var vm = CartViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background
                Color.mainBg.ignoresSafeArea()
                
                // foreground
                cartViewScrollView
            }
            .navigationTitle("checkout".capitalized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CartView()
}




extension CartView {
    
    private var cartViewScrollView: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack {
                    ForEach(vm.cartItems) { cartItem in
                        CartItemView(cartItem: cartItem, vm: vm)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
            }
            
            if !vm.cartItems.isEmpty {
                CartTotalPriceItemView(vm: vm)
            }
            
        }
    }
    
}
