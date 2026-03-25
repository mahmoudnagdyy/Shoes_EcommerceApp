//
//  SizeItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 25/03/2026.
//

import SwiftUI

struct SizeItemView: View {
    
    let item: ProductSizeModel
    @Binding var selectedSize: ProductSizeModel?
    
    var body: some View {
        Text(item.size.description)
            .font(.title2)
            .bold()
            .frame(width: 60, height: 60)
            .background(selectedSize == item ? Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)) : .gray.opacity(0.2))
            .foregroundStyle(selectedSize == item ? .white : .black)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .onTapGesture {
                withAnimation(.spring) {
                    selectedSize = item
                }
            }
    }
}

#Preview {
    SizeItemView(item: ProductSizeModel(id: "", size: 49, stock: 49), selectedSize: .constant(nil))
}
