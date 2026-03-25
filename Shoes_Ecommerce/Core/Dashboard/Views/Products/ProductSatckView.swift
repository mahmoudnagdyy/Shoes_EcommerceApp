//
//  ProductSatckView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import SwiftUI
internal import Combine

class ProductStackViewModel: ObservableObject {
    
    @Published var productCategory: CategoryModel?
    @Published var product: ProductModel
    @Published var sizes: [ProductSizeModel] = []
    @Published var selectedSize: ProductSizeModel?
    
    var cancellables = Set<AnyCancellable>()
    
    init(product: ProductModel) {
        self.product = product
        getProductCategory(categoryId: product.categoryId)
        if !product.id.isEmpty {
            getProductSizes(productId: product.id)
        }
    }
    
    func getProductCategory(categoryId: String) {
        Task {
            do {
                self.productCategory = try await FirestoreCategoryManager.shared.getCategory(categoryId: categoryId)
            } catch {
                print(error)
            }
        }
    }
    
    func getProductSizes(productId: String) {
        FirestoreProductManager.shared.getProductSizesUsingListener(productId: productId)
            .sink { [weak self] productSizes in
                self?.sizes = productSizes
                self?.selectedSize = productSizes.first
            }
            .store(in: &cancellables)
    }
    
}

struct ProductSatckView: View {
    
    @StateObject var psVM: ProductStackViewModel
    let product: ProductModel
    @ObservedObject var dbVM: DashboardViewModel
    @State var showAddSize: Bool = false
    
    
    init(product: ProductModel, dbVM: DashboardViewModel) {
        _psVM = StateObject(wrappedValue: ProductStackViewModel(product: product))
        self.product = product
        self.dbVM = dbVM
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
        ProductSatckView(product: productPrev, dbVM: DashboardViewModel())
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
//                        if let user = dbVM.user,
//                           user.role == UserType.admin.rawValue {
                            addSizeButton
//                        }
                    }
                    .padding(.top)
                    
                    productSizesScrollView
                    
                    if psVM.sizes.count > 0 {
                        sizeStockText
                    }
                    
                    Text("description".capitalized)
                        .font(.headline)
                        .padding(.top)
                    Text(product.description)
                        .foregroundStyle(.gray)
                    
                    if psVM.sizes.count > 0 {
                        addToCartButton
                    }
                        
                }
                .padding()
                .fullScreenCover(isPresented: $showAddSize) {
                    AddSizeView(vm: dbVM, product: product)
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
            dbVM.makeProductFavorite(product: product)
        } label: {
            Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(product.isFavorite ? .red : .black)
        }
    }
    
    private var productNameAndPriceView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.productName.capitalized)
                    .font(.title)
                    .bold()
                Text(psVM.productCategory?.categoryName.capitalized ?? "N/A")
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
                ForEach(psVM.sizes) { item in
                    SizeItemView(item: item, selectedSize: $psVM.selectedSize)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var sizeStockText: some View {
        HStack {
            Text("stock:".capitalized)
                .font(.headline)
            Text(psVM.selectedSize?.stock.description ?? "0")
                .font(.subheadline)
        }
        .padding(.top)
    }
    
    private var addToCartButton: some View {
        SubmitButton(text: "add to cart", bgColor: .black) {
            // action
        }
        .disabled(psVM.selectedSize?.stock == 0 ? true : false)
        .opacity(psVM.selectedSize?.stock == 0 ? 0.4 : 1)
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
