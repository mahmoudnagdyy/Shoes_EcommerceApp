//
//  FavoriteItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import SwiftUI
internal import Combine


class FavoriteItemViewModel: ObservableObject {
    
    @Published var productCategory: CategoryModel?
    
    let firestoreCategoryManager: FirestoreCategoryProtocol
    
    init(categoryId: String, firestoreCategoryManager: FirestoreCategoryProtocol) {
        self.firestoreCategoryManager = firestoreCategoryManager
        getProductCategory(categoryId: categoryId)
    }
    
    private func getProductCategory(categoryId: String) {
        Task {
            do {
                self.productCategory = try await firestoreCategoryManager.getCategory(categoryId: categoryId)
            } catch {
                print(error)
            }
        }
    }
    
}



struct FavoriteItemView: View {
    
    let product: ProductModel
    @ObservedObject var favVm: FavoritesViewModel
    @StateObject var  itemVm: FavoriteItemViewModel
    
    private var isFavorite: Bool {
        favVm.favoriteProducts.contains(where: { $0.id == product.id })
    }
    
    init(product: ProductModel, favVm: FavoritesViewModel) {
        self.product = product
        self.favVm = favVm
        _itemVm = StateObject(wrappedValue: FavoriteItemViewModel(categoryId: product.categoryId, firestoreCategoryManager: FirestoreCategoryManager()))
    }
    
    var body: some View {
        HStack {
            favoriteImage
            favoriteDetailsTexts
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(content: {
            RoundedRectangle(cornerRadius: 25)
                .stroke(.gray.opacity(0.4), lineWidth: 3)
        })
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    FavoriteItemView(product: ProductModel(id: "1", productName: "nike one", categoryId: "222", description: "", images: [], price: 0), favVm: FavoritesViewModel())
}


extension FavoriteItemView {
    
    private var toggleFavoriteButton: some View {
        Button {
            favVm.addFavoriteProduct(product: product)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 25, height: 25)
                .offset(x: 10, y: 15)
                .foregroundStyle(isFavorite ? .red : .black)
        }
    }
    
    private var favoriteDetailsTexts: some View {
        VStack(alignment: .leading) {
            Text(product.productName.capitalized)
                .font(.title2)
                .bold()
                .foregroundStyle(.black)
            
            Text(itemVm.productCategory?.categoryName.capitalized ?? "nike")
                .foregroundStyle(.gray.opacity(0.5))
                .fontWeight(.semibold)
        }
        .padding(.horizontal)
    }
    
    private var favoriteImage: some View {
        WebImageItem(imageUrl: product.images.first?.secureUrl ?? "", width: 150, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(alignment: .topLeading) {
                toggleFavoriteButton
            }
    }
    
}
