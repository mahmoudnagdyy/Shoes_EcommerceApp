//
//  AddSizeView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import SwiftUI

struct AddSizeView: View {
    
    @ObservedObject var vm: ProductStackViewModel
    let product: ProductModel
    @Environment(\.dismiss) var dismiss
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            addSizeForeground
        }
    }
}

#Preview {
    let product = ProductModel(id: "1", productName: "nike", categoryId: "2", description: "", images: [], price: 0)
    
    AddSizeView(vm: ProductStackViewModel(product: product), product: product)
}


extension AddSizeView {
    
    private var addSizeForeground: some View {
        ScrollView(.vertical) {
            VStack {
                XButtonView {
                    dismiss()
                }
                
                Image("size_image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                
                DashboardTextField(title: "size", text: $vm.productSize)
                    .keyboardType(.numberPad)
                
                DashboardTextField(title: "stock", text: $vm.productSizeStock)
                    .keyboardType(.numberPad)
                
                SubmitButton(text: "save size", bgColor: .black) {
                    addSizeButtonFunction()
                }
                
                if isLoading {
                    ProgressView()
                        .tint(.black)
                }
                
            }
            .padding()
        }
    }
    
}


extension AddSizeView {
    
    private func addSizeButtonFunction() {
        Task {
            do {
                isLoading = true
                try await vm.saveSize(productId: product.id)
                isLoading = false
                vm.productSize = ""
                vm.productSizeStock = ""
            } catch {
                print(error)
            }
        }
    }
    
}
