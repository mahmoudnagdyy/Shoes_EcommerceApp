//
//  TabItemPreferenceKey.swift
//  Shoes_Ecommerce
//
//  Created by Mahmoud Nagdy on 22/03/2026.
//

import Foundation
import SwiftUI


struct TabItemPreferenceKey: PreferenceKey {
    
    static var defaultValue: [TabModel] = []
    
    static func reduce(value: inout [TabModel], nextValue: () -> [TabModel]) {
        value += nextValue()
    }
    
}
