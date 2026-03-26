//
//  CategoriesView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import SwiftUI

struct CategoriesView: View {
    
    @StateObject var vm = CategoryViewModel()
    @State private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var showAddCategoryView: Bool = false
    
    var body: some View {
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            categoriesForeground
        }
    }
}

#Preview {
    CategoriesView(vm: CategoryViewModel())
}


extension CategoriesView {
    
    private var categoriesForeground: some View {
        VStack {
            CategoriesHeaderText
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach(vm.categories) { category in
                        CategoryItemView(category: category)
                    }
                }
                .padding(.bottom, 100)
            }
            .scrollIndicators(.hidden)
            
        }
        .padding()
        .fullScreenCover(isPresented: $showAddCategoryView) {
            AddCategoryView(vm: vm)
        }
    }
    
    private var CategoriesHeaderText: some View {
        HStack {
            Text("Categories")
            Spacer()
            Image(systemName: "plus")
                .frame(width: 50, height: 50)
                .background(.white)
                .clipShape(.circle)
                .onTapGesture {
                    showAddCategoryView.toggle()
                }
        }
        .font(.title)
        .bold()
    }
    
}
