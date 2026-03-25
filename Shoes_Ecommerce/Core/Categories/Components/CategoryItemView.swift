//
//  CategoryItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import SwiftUI

struct CategoryItemView: View {
    
    let category: CategoryModel
    
    var body: some View {
        VStack {
            WebImageItem(imageUrl: category.image.secureUrl, width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            Text(category.categoryName.capitalized)
                .font(.title2)
                .bold()
        }
    }
}

#Preview {
    CategoryItemView(category: CategoryModel(id: "", categoryName: "nike", image: ImageModel(publicId: "", secureUrl: "")))
}
