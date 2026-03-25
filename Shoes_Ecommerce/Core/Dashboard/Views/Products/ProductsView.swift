//
//  ProductsView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import SwiftUI

struct ProductsView: View {
    
    @ObservedObject var vm: DashboardViewModel
    @State private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var showAddProduct: Bool = false
    
    var body: some View {
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            productForeground
        }
    }
}

#Preview {
    NavigationStack {
        ProductsView(vm: DashboardViewModel())
    }
}


extension ProductsView {
    
    private var productForeground: some View {
        VStack {
            productsHeaderText
            
            productScrollView
        }
        .padding()
        .fullScreenCover(isPresented: $showAddProduct) {
            AddProductView(vm: vm)
        }
    }
    
    private var productScrollView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(vm.products) { product in
                    NavigationLink {
                        ProductSatckView(product: product, dbVM: vm)
                    } label: {
                        ProductItemView(product: product) {
                            vm.makeProductFavorite(product: product)
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var productsHeaderText: some View {
        HStack {
            Text("products".capitalized)
            Spacer()
            Image(systemName: "plus")
                .frame(width: 50, height: 50)
                .background(.white)
                .clipShape(.circle)
                .onTapGesture {
                    showAddProduct.toggle()
                }
        }
        .font(.title)
        .bold()
    }
    
    
    
}
