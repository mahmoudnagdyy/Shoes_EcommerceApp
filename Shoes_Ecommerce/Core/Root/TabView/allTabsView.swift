//
//  allTabsView.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import SwiftUI

struct TabModel: Equatable {
    let title: String
    let iconName: String
    
    static func ==(lhs: TabModel, rhs: TabModel) -> Bool {
        return lhs.title == rhs.title
    }
}

struct allTabsView: View {
    
    @Binding var allTabs: [TabModel]
    @Binding var selectedTab: TabModel
    @Namespace var namespaces
    
    var body: some View {
        HStack {
            ForEach(allTabs, id: \.title) { tab in
                TabItemView(tab: tab)
                    .font(selectedTab == tab ? .title2 : .body)
                    .offset(y: selectedTab == tab ? -25 : 0)
                    .foregroundStyle(selectedTab == tab ? Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)) : .black)
                    .background(content: {
                        if selectedTab == tab {
                            VStack(spacing: -10) {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 55, height: 55)
                                    .shadow(radius: 5, y: -2)
                                    .offset(y: selectedTab == tab ? -20 : 0)
                                    
                                Text(selectedTab.title.capitalized)
                                    .font(.caption)
                                    .bold()
                            }
                            .matchedGeometryEffect(id: "selectedTab", in: namespaces)
                        }
                    })
                    .onTapGesture {
                        withAnimation(.spring) {
                            selectedTab = tab
                        }
                    }
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color(#colorLiteral(red: 0.8862745098, green: 0.4588235294, blue: 0.3254901961, alpha: 1)))
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    VStack {
        Spacer()
        allTabsView(allTabs: .constant([]), selectedTab: .constant(TabModel(title: "", iconName: "")))
    }
}
