//
//  DashboardView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var vm = DashboardViewModel()
    
    var body: some View {
        ZStack {
            // background
            Color(#colorLiteral(red: 0.8941176471, green: 0.8901960784, blue: 0.8745098039, alpha: 1)).ignoresSafeArea()
            
            // Foreground
            NavigationStack {
                List {
                    NavigationLink {
                        CategoriesView(vm: vm)
                    } label: {
                        HStack {
                            Text("categories".capitalized)
                                .font(.headline)
                            Spacer()
                            if vm.categories.count > 0 {
                                categoriesCountText
                            }
                        }
                    }
                    
                    NavigationLink {
                        ProductsView(vm: vm)
                    } label: {
                        Text("products".capitalized)
                            .font(.headline)
                    }

                }
                .navigationTitle("dashboard".capitalized)
            }
        }
    }
}

#Preview {
    DashboardView()
}


extension DashboardView {
    
    private var categoriesCountText: some View {
        Circle()
            .fill(.red)
            .frame(width: 25, height: 25)
            .overlay {
                Text("\(vm.categories.count)")
                    .foregroundStyle(.white)
                    .font(.headline)
            }
    }
    
}
