//
//  ProductSatckView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import SwiftUI

struct ProductSatckView: View {
    
    @StateObject var vm: ProductStackViewModel
    @ObservedObject var favVM: FavoritesViewModel
    let product: ProductModel
    @State var showAddSize: Bool = false
    
    private var isFavorite: Bool {
        return favVM.favoriteProducts.contains(where: { $0.id == product.id })
    }
    
    init(product: ProductModel, favVm: FavoritesViewModel) {
        _vm = StateObject(wrappedValue: ProductStackHelper.makeProductStackView(product: product))
        self.product = product
        self.favVM = favVm
    }
    
    
    var body: some View {
        ZStack {
            // background
            Color.mainBg.ignoresSafeArea()
            
            // foreground
            productStackForeground
        }
        .navigationTitle("details".capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if let user = vm.user,
               user.role == UserType.admin.rawValue {
                ToolbarItem(placement: .topBarLeading) {
                    editProductButton
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    deleteProductButton
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                isFavoriteButton
            }
        }
    }
}

#Preview {
    let productPrev = ProductModel(
        id: "preview",
        productName: "Nike Air",
        categoryId: "previewCategory",
        description: "Sample shoe",
        images: [],
        price: 120
    )
    NavigationStack {
        ProductSatckView(product: productPrev, favVm: FavoritesViewModel())
    }
}


extension ProductSatckView {
    
    private var productStackForeground: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                productImagesTabView
                
                VStack(alignment: .leading) {
                    productNameAndPriceView
                    
                    HStack {
                        Text("select size".capitalized)
                            .font(.headline)
                        Spacer()
                        if let user = vm.user,
                           user.role == UserType.admin.rawValue {
                            addSizeButton
                        }
                    }
                    .padding(.top)
                    
                    productSizesScrollView
                    
                    if vm.sizes.count > 0 {
                        sizeStockText
                    }
                    
                    Text("description".capitalized)
                        .font(.headline)
                        .padding(.top)
                    Text(product.description)
                        .foregroundStyle(.gray)
                    
                    if vm.sizes.count > 0 {
                        addToCartButton
                    }
                        
                }
                .padding()
                .fullScreenCover(isPresented: $showAddSize) {
                    AddSizeView(vm: vm, product: product)
                }
            }
            .padding(.bottom, 100)
        }
    }
    
    private var productImagesTabView: some View {
        TabView {
            ForEach(product.images, id: \.self) { image in
                WebImageItem(imageUrl: image.secureUrl, width: 400, height: 400)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .tabViewStyle(.page)
    }
    
    private var isFavoriteButton: some View {
        Button {
            vm.addFavoriteProduct(product: product)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .foregroundStyle(isFavorite ? .red : .black)
        }
    }
    
    private var deleteProductButton: some View {
        Button {
            // action
        } label: {
            Image(systemName: "trash.fill")
        }
    }
    
    private var editProductButton: some View {
        Button {
            // action
        } label: {
            Image(systemName: "pencil")
        }
    }
    
    private var productNameAndPriceView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.productName.capitalized)
                    .font(.title)
                    .bold()
                Text(vm.productCategory?.categoryName.capitalized ?? "N/A")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            Spacer()
            productPriceText(price: product.price)
        }
    }
    
    private var addSizeButton: some View {
        Image(systemName: "plus")
            .frame(width: 30, height: 30)
            .background(.white)
            .clipShape(.circle)
            .font(.headline)
            .onTapGesture {
                showAddSize.toggle()
            }
    }
    
    private var productSizesScrollView: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(vm.sizes) { item in
                    SizeItemView(item: item, selectedSize: $vm.selectedSize)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var sizeStockText: some View {
        HStack {
            Text("stock:".capitalized)
                .font(.headline)
            Text(vm.selectedSize?.stock.description ?? "0")
                .font(.subheadline)
        }
        .padding(.top)
    }
    
    private var addToCartButton: some View {
        SubmitButton(text: "add to cart", bgColor: .black, fgColor: .white) {
            vm.addItemToCart(product: product)
        }
        .disabled(vm.selectedSize?.stock == 0 ? true : false)
        .opacity(vm.selectedSize?.stock == 0 ? 0.4 : 1)
    }
    
}


extension ProductSatckView {
    
    private func productPriceText(price: Double) -> some View {
        HStack(spacing: 5) {
            Text("$")
                .foregroundStyle(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)))
            Text(price.description)
                .foregroundStyle(.black)
        }
        .font(.title2)
        .bold()
    }
    
}




struct ProductStackHelper {
    
    static func makeProductStackView(product: ProductModel) -> ProductStackViewModel {
        let firestoreUserManager: FirestoreUserProtocol = FirestoreUserManager()
        let firestoreProductManager: FirestoreProductProtocol = FirestoreProductManager()
        let firestoreCategoryManager: FirestoreCategoryProtocol = FirestoreCategoryManager()
        let firestoreFavoriteManager: FirestoreFavoriteProtocol = FirestoreFavoriteManager()
        let firestoreCartManager: FirestoreCartProtocol = FirestoreCartManager()
        return ProductStackViewModel(
            product: product,
            firestoreUserManager: firestoreUserManager,
            firestoreProductManager: firestoreProductManager,
            firestoreCategoryManager: firestoreCategoryManager,
            firestoreFavoriteManager: firestoreFavoriteManager,
            firestoreCartManager: firestoreCartManager)
    }
    
}
