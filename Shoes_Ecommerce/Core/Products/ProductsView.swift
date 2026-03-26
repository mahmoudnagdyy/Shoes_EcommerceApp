//
//  ProductsView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import SwiftUI

struct ProductsView: View {
    
    @StateObject var vm = ProductViewModel()
    @StateObject var favVm = FavoritesViewModel()
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
        ProductsView()
    }
}


extension ProductsView {
    
    private var productForeground: some View {
        VStack {
            productsHeaderText
            
            productsScrollView
        }
        .padding()
        .fullScreenCover(isPresented: $showAddProduct) {
            AddProductView(vm: vm)
        }
    }
    
    private var productsScrollView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(vm.products) { product in
                    NavigationLink {
                        ProductSatckView(product: product, favVm: favVm)
                    } label: {
                        ProductItemView(product: product, favVm: favVm)
                    }
                }
            }
            .padding(.bottom, 100)
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
