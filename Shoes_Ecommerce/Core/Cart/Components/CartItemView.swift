//
//  CartItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 26/03/2026.
//

import SwiftUI

struct CartItemView: View {
    
    let cartItem: CartItemModel
    @ObservedObject var vm: CartViewModel
    @State var totalPrice: Double = 0
    @State var quantity: Int
    
    
    init(cartItem: CartItemModel, vm: CartViewModel) {
        self.cartItem = cartItem
        self.vm = vm
        self._quantity = State(wrappedValue: cartItem.quantity)
        self._totalPrice = State(wrappedValue: cartItem.totalPrice)
    }
    
    var body: some View {
        HStack {
            if let imageUrl = cartItem.product.images.first?.secureUrl {
                WebImageItem(imageUrl: imageUrl, width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            VStack(alignment: .leading) {
                Text(cartItem.product.productName.capitalized)
                    .font(.title3)
                    .bold()
                Text("size \(cartItem.size.size)".capitalized)
                    .font(.headline)
                    .foregroundStyle(.gray.opacity(0.6))
                cartItemProductDetails
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .onChange(of: quantity) { oldValue, newValue in
            totalPrice = Double(newValue) * cartItem.product.price
        }
    }
}

#Preview {
    let cartItem = CartItemModel(
        id: "",
        product: ProductModel(id: "", productName: "", categoryId: "",
                              description: "",images: [], price: 0),
        size: ProductSizeModel(id: "", size: 0, stock: 0),
        quantity: 0)
    CartItemView(cartItem: cartItem, vm: CartViewModel())
}



extension CartItemView {
    
    private var cartItemProductDetails: some View {
        HStack {
            Text(totalPrice.asPriceString())
                .bold()
            Spacer()
            HStack(spacing: 10) {
                cartItemDecreaseButton
//                Text("\(cartItem.quantity)")
                Text("\(quantity)")
                cartItemIncreaseButton
            }
            .font(.headline)
        }
    }
    
    private var cartItemDecreaseButton: some View {
        Button {
            if quantity >= 1 {
                quantity -= 1
                vm.decreaseQuantity(of: cartItem, sizeId: cartItem.size.id)
            }
        } label: {
            Text("-")
                .frame(width: 30, height: 30)
                .background(.gray.opacity(0.5))
                .foregroundStyle(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var cartItemIncreaseButton: some View {
        Button {
            quantity += 1
            vm.increaseQuantity(of: cartItem, sizeId: cartItem.size.id)
        } label: {
            Text("+")
                .frame(width: 30, height: 30)
                .background(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)))
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
}
