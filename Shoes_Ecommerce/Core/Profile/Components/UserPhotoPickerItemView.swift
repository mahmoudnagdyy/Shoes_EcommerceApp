//
//  PhotoPickerItemView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 23/03/2026.
//

import SwiftUI

struct UserPhotoPickerItemView: View {
    
    let imageLink: String
    @Binding var showChangeImageCover: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            UserWebImageItem(imageUrl: imageLink, width: 150, height: 150)
            Image(systemName: "pencil.circle.fill")
                .font(.title)
                .offset(x: 18, y: 10)
                .onTapGesture {
                    showChangeImageCover.toggle()
                }
        }
    }
}

#Preview {
    UserPhotoPickerItemView(imageLink: "", showChangeImageCover: .constant(false))
}
