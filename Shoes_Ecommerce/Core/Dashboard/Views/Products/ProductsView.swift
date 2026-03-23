//
//  ProductsView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 24/03/2026.
//

import SwiftUI

struct ProductsView: View {
    
    @ObservedObject var vm: DashboardViewModel
    
    var body: some View {
        Text("products")
    }
}

#Preview {
    ProductsView(vm: DashboardViewModel())
}
