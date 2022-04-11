//
//  Product.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import Foundation
import Combine
import SwiftUI

struct Product: Identifiable {
    
    var id = UUID()
    var name: String
    var image: String
    var price: Double
    var addedToCart: Bool = false
    var count: Int = 1
    var offset: CGFloat = 0
    var isSwiped: Bool = false
    var category: String = ""
    var expirationDate: String
    var country: String
    var storageConditions: String
}
