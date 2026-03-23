//
//  AddCategoriesView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import SwiftUI
import PhotosUI

struct AddCategoriesView: View {
    
    @ObservedObject var vm: DashboardViewModel
    @Environment(\.dismiss) var dismiss
    @State var isloading: Bool = false
    
    var body: some View {
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            AddCategoriesForeground
        }
    }
}

#Preview {
    AddCategoriesView(vm: DashboardViewModel())
}


extension AddCategoriesView {
    
    private var AddCategoriesForeground: some View {
        ScrollView(.vertical) {
            VStack {
                xmarkButton
                
                categoryUploadPhotoPicker
                
                categoryNameTextField
                
                createCategoryButton
                
                if isloading {
                    ProgressView()
                        .tint(.black)
                }
                
            }
            .padding()
        }
    }
    
    private var xmarkButton: some View {
        Image(systemName: "xmark")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
                dismiss()
            }
    }
    
    private var categoryUploadPhotoPicker: some View {
        
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .clipShape(.circle)
                } else {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                }
            }
            .frame(width: 200, height: 200)
            
            PhotosPicker(selection: $vm.selectedImage) {
                Image(systemName: "camera.fill")
                    .foregroundStyle(.black)
                    .font(.title)
                    .offset(x: 10, y: 10)
            }
            
        }
        .padding(.vertical, 40)
    }
    
    private var categoryNameTextField: some View {
        TextField("category name".capitalized, text: $vm.categoryName)
            .frame(height: 60)
            .padding(.horizontal)
            .background(.white)
            .clipShape(.capsule)
            .font(.headline)
    }
    
    private var createCategoryButton: some View {
        SubmitButton(text: "create category", bgColor: .black) {
            Task {
                do {
                    isloading = true
                    try await vm.createCategory()
                    isloading = false
                    vm.categoryName = ""
                    vm.selectedImage = nil
                    vm.image = nil
                } catch {
                    isloading = false
                    print(error)
                }
            }
        }
        .disabled(isloading)
        .opacity(isloading ? 0.4 : 1)
    }
    
}
