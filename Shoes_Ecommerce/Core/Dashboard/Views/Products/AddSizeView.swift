//
//  AddSizeView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import SwiftUI

struct AddSizeView: View {
    
    @ObservedObject var vm: DashboardViewModel
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
    AddSizeView(vm: DashboardViewModel(), product: ProductModel(id: "", productName: "", categoryId: "", description: "", images: [], price: 0))
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
