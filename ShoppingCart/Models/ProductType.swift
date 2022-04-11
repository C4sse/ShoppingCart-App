//
//  ProductType.swift
//  ShoppingCart
//
//  Created by George Nhari on 8/4/2022.
//

import Foundation
import SwiftUI

struct ProductType: Identifiable {
    
    var id = UUID()
    var name: String
    var image: String
    var category: [String] = []
}
