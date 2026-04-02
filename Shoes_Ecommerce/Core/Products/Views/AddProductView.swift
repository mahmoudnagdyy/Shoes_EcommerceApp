//
//  AddProductView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import SwiftUI
import PhotosUI

struct AddProductView: View {
    
    @ObservedObject var vm: ProductViewModel
    @Environment(\.dismiss) var dismiss
    @State var isloading: Bool = false
    
    var body: some View {
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            AddProductsForeground
        }
    }
}

#Preview {
    AddProductView(vm: ProductViewModel(firestoreUserManager: FirestoreUserManager(), firestoreProductManager: FirestoreProductManager(), firesoreCategoryManager: FirestoreCategoryManager(), uploadPhotoService: ProductService()))
}


extension AddProductView {
    
    private var AddProductsForeground: some View {
        ScrollView(.vertical) {
            VStack {
                XButtonView {
                    dismiss()
                }
                
                productUploadPhotoPicker
                
                productNameTextField
                
                selectCategoryPicker
                
                productPriceTextField
                
                descriptionTextLabel
                productDescriptionTextEditor
                
//                createProductButton
//                
//                if isloading {
//                    ProgressView()
//                        .tint(.black)
//                }
                
                ZStack {
                    if isloading {
                        Capsule()
                            .frame(height: 60)
                            .overlay {
                                LottieView(name: "loading_hand2")
                                    .frame(width: 60)
                            }
                            .padding(.vertical, 10)
                    } else{
                        createProductButton
                    }
                }
                
            }
            .padding()
        }
    }
    
    private var productUploadPhotoPicker: some View {
        
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let productImages = vm.productImages {
                    productImagesScrollView(productImages: productImages)
                } else {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                }
            }
            
            PhotosPicker(selection: $vm.selectedProductImages, maxSelectionCount: 4) {
                Image(systemName: "camera.fill")
                    .foregroundStyle(.black)
                    .font(.title)
                    .offset(x: 10, y: 10)
            }
            
        }
        .padding(.vertical, 40)
    }
    
    private var productNameTextField: some View {
        DashboardTextField(title: "product name", text: $vm.productName)
    }
    
    private var productPriceTextField: some View {
        DashboardTextField(title: "price", text: $vm.productPrice)
    }
    
    private var selectCategoryPicker: some View {
        HStack {
            Text("select category".capitalized)
            Spacer()
            Picker("category".capitalized, selection: $vm.productCategory) {
                ForEach(vm.categories) { category in
                    Text(category.categoryName.capitalized)
                        .tag(category)
                }
            }
        }
        .frame(height: 60)
        .padding(.horizontal)
        .background(.white)
        .clipShape(.capsule)
        .font(.headline)
    }
    
    private var descriptionTextLabel: some View {
        Text("description".capitalized)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.headline)
            .foregroundStyle(.gray)
            .padding(.top, 10)
    }
    
    private var productDescriptionTextEditor: some View {
        TextEditor(text: $vm.productDescription)
            .frame(height: 150)
            .padding(10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    private var createProductButton: some View {
        SubmitButton(text: "create product", bgColor: .black, fgColor: .white) {
            createProductButtonFunction()
        }
        .disabled(isloading)
        .opacity(isloading ? 0.4 : 1)
    }
    
    
}




extension AddProductView {
    
    private func productImagesScrollView(productImages: [UIImage]) -> some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(productImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .scaledToFill()
                }
            }
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
    }
    
    private func createProductButtonFunction() {
        Task {
            do {
                isloading = true
                try await vm.createProduct()
                isloading = false
                vm.productImages = nil
                vm.productName = ""
                vm.productDescription = ""
                vm.productPrice = ""
            } catch {
                isloading = false
                print(error)
            }
        }
    }
    
}
