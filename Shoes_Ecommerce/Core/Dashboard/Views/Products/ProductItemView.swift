//
//  ProductItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import SwiftUI

struct ProductItemView: View {
    
    let product: ProductModel
    let onFavoriteTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack(alignment: .topTrailing) {
                WebImageItem(imageUrl: product.images.first?.secureUrl ?? "",
                             width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Button {
                    onFavoriteTapped()
                } label: {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .offset(x: -15, y: 15)
                        .foregroundStyle(product.isFavorite ? .red : .black)
                }
            }
            
            productPriceText(price: product.price)
            
            Text(product.productName.capitalized)
                .fontWeight(.medium)
                .foregroundStyle(.black)
            
        }
        .frame(width: 160)
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    ProductItemView(product: ProductModel(id: "", productName: "", categoryId: "", description: "", images: [], price: 120)) {
        
    }
}


extension ProductItemView {
    
    private func productPriceText(price: Double) -> some View {
        HStack(spacing: 5) {
            Text("$")
                .foregroundStyle(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)))
            Text(price.description)
                .foregroundStyle(.black)
        }
        .font(.title3)
        .bold()
    }
    
}
