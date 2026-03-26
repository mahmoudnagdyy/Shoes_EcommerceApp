//
//  HomeCategoryItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 26/03/2026.
//

import SwiftUI

struct HomeCategoryItemView: View {
    
    let category: CategoryModel
    @Binding var selectedCategory: CategoryModel?
    
    var body: some View {
        homeCategoryItem
    }
}

#Preview {
    HomeCategoryItemView(category: CategoryModel(id: "1", categoryName: "nike", image: ImageModel(publicId: "", secureUrl: "")), selectedCategory: .constant(nil))
}



extension HomeCategoryItemView {
    
    private var homeCategoryItem: some View {
        HStack {
            WebImageItem(imageUrl: category.image.secureUrl, width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            if selectedCategory == category {
                Text(category.categoryName.capitalized)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .bold()
            }
        }
        .frame(height: 80)
        .padding(.leading, selectedCategory == category ? 10 : 0)
        .padding(.trailing, selectedCategory == category ? 20 : 0)
        .background(selectedCategory == category ? Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)) : .clear)
        .cornerRadius(selectedCategory == category ? 15 : 0)
        .onTapGesture {
            withAnimation(.spring) {
                selectedCategory = category
            }
        }
    }
    
}
