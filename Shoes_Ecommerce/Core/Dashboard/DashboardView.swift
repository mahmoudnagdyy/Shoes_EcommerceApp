//
//  DashboardView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var vm: DashboardViewModel
    @Environment(\.dismiss) var dismiss
    
    init() {
        _vm = StateObject(wrappedValue: DashboardHelper.makeDashboardView())
    }
    
    var body: some View {
        ZStack {
            // background
            Color(#colorLiteral(red: 0.8941176471, green: 0.8901960784, blue: 0.8745098039, alpha: 1)).ignoresSafeArea()
            
            // Foreground
            NavigationStack {
                List {
                    NavigationLink {
                        CategoriesView()
                    } label: {
                        HStack {
                            Text("categories".capitalized)
                                .font(.headline)
                            Spacer()
                            if vm.categoriesCount > 0 {
                                categoriesCountText
                            }
                        }
                    }
                    
                    NavigationLink {
                        ProductsView()
                    } label: {
                        HStack {
                            Text("products".capitalized)
                                .font(.headline)
                            Spacer()
                            if vm.productsCount > 0 {
                                productsCountText
                            }
                        }
                    }

                }
                .navigationTitle("dashboard".capitalized)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                        }

                    }
                }
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
                Text("\(vm.categoriesCount)")
                    .foregroundStyle(.white)
                    .font(.headline)
            }
    }
    
    private var productsCountText: some View {
        Circle()
            .fill(.red)
            .frame(width: 25, height: 25)
            .overlay {
                Text("\(vm.productsCount)")
                    .foregroundStyle(.white)
                    .font(.headline)
            }
    }
    
}




struct DashboardHelper {
    
    static func makeDashboardView() -> DashboardViewModel {
        let firestoreProductManager: FirestoreProductProtocol = FirestoreProductManager()
        let firestoreCategoryManager = FirestoreCategoryManager()
        return DashboardViewModel(firestoreProductManager: firestoreProductManager, firestoreCategoryManager: firestoreCategoryManager)
    }
    
}
