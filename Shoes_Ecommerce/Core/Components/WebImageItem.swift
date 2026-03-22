//
//  WebImageItem.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct WebImageItem: View {
    
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    
    init(imageUrl: String, width: CGFloat, height: CGFloat) {
        self.url = URL(string: imageUrl)
        self.width = width
        self.height = height
    }
    
    var body: some View {
        WebImage(url: url) { image in
            image
                .resizable()
                .frame(width: width, height: height)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .stroke(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)), lineWidth: 3)
                }
        } placeholder: {
            Circle()
                .frame(width: width, height: height)
                .overlay {
                    ProgressView()
                        .tint(.white)
                }
        }
    }
}

#Preview {
    WebImageItem(imageUrl: "", width: 50, height: 50)
}
