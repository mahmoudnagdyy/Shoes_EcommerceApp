//
//  ProfileView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        ZStack {
            // background
            Color(#colorLiteral(red: 0.8941176471, green: 0.8901960784, blue: 0.8745098039, alpha: 1)).ignoresSafeArea()
            
            // foreground
            profileForegroundContainer
        }
    }
}

#Preview {
    ProfileView()
}


extension ProfileView {
    
    private var profileForegroundContainer: some View {
        ScrollView(.vertical) {
            VStack {
                
                logoutButton
                
                if let photoUrl = vm.user?.photoUrl {
                    WebImageItem(imageUrl: photoUrl, width: 100, height: 100)
                } else {
                    noUserImage
                }
                
                displayUserName()
                
                HStack {
                    Image(systemName: "envelope.fill")
                    Text(vm.user?.email ?? "no email")
                }
                
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
    }
    
    private var noUserImage: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .overlay {
                Circle()
                    .stroke(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)), lineWidth: 3)
            }
    }
    
    private var logoutButton: some View {
        Button {
            // action
        } label: {
            Image(systemName: "iphone.and.arrow.forward.outward")
                .frame(width: 55, height: 55)
                .background(.white)
                .clipShape(.circle)
                .padding()
                .foregroundStyle(.red)
                .font(.title)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
}


extension ProfileView {
    
    private func displayUserName() -> some View {
        let firstName = vm.user?.firstName ?? "fName"
        let lastName = vm.user?.lastName ?? "lName"
        return Text("\(firstName) \(lastName)".capitalized).font(.largeTitle).bold()
    }
    
}
