//
//  CartTotalPriceItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 27/03/2026.
//

import SwiftUI

struct CartTotalPriceItemView: View {
    
    @ObservedObject var vm: CartViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            subTotalForProducts
            
            deliveryFee
            
            Text("-----------------------------------------------")
                .foregroundStyle(.white)
                .font(.headline)
            
            totalPrice
            
            SubmitButton(text: "checkout".capitalized, bgColor: .white, fgColor: .black) {
                
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 350)
        .padding()
        .background {
            UnevenRoundedRectangle(topLeadingRadius: 25, topTrailingRadius: 25)
                .fill(Color(#colorLiteral(red: 0.06133121252, green: 0.4122267962, blue: 0.4122133255, alpha: 1)))
                .ignoresSafeArea()
        }
    }
}

#Preview {
    CartTotalPriceItemView(vm: CartViewModel(firestoreCartManager: FirestoreCartManager()))
}



extension CartTotalPriceItemView {
    
    private var subTotalForProducts: some View {
        HStack {
            Text("subTotal for products")
            Spacer()
            Text(vm.totalCartPrice.asPriceString())
        }
        .foregroundStyle(.white)
        .font(.headline)
        .padding(.top, 10)
    }
    
    private var deliveryFee: some View {
        HStack {
            Text("Delivery subTotal")
            Spacer()
            Text("$ 50.00")
        }
        .foregroundStyle(.white)
        .font(.headline)
        .padding(.top, 10)
    }
    
    private var totalPrice: some View {
        HStack {
            Text("total".capitalized)
            Spacer()
            Text((vm.totalCartPrice + 50.0).asPriceString())
        }
        .foregroundStyle(.white)
        .font(.headline)
        .padding(.bottom, 5)
    }
    
}
