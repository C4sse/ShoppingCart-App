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
}

var productList = [Product(name: "Orange sweater", image: "fruit1", price: 34.99),
                   Product(name: "Red wine sweater", image: "fruit2", price: 24.99),
                   Product(name: "Sand Sweater", image: "fruit3", price: 33.50),
                   Product(name: "Sea sweater", image: "fruit4", price: 34.99),
                   Product(name: "Cream sweater", image: "sweater5", price: 31.99),
                   Product(name: "Beige sweater", image: "sweater6", price: 29.99),
                   Product(name: "Grey sweater", image: "sweater7", price: 27.45),
                   Product(name: "Mink sweater", image: "sweater8", price: 26.00)]

let backgroundColor1 = Color(red: 238 / 255, green: 241 / 255, blue: 246 / 255)
let backgroundColor2 = Color(red: 248 / 255, green: 248 / 255, blue: 248 / 255)
let backgroundColor3 = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
let redAccent = Color(red: 224 / 255, green: 33 / 255, blue: 56 / 255)
let orangeAccent = Color(red: 245 / 255, green: 112 / 255, blue: 57 / 255)
let blueAccent = Color(red: 35 / 255, green: 174 / 255, blue: 253 / 255)
let blueBasic = Color(red: 0 / 255, green: 122 / 255, blue: 255 / 255)
let greenBasic = Color(red: 57 / 255, green: 181 / 255, blue: 78 / 255)
let blackBasic = Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255)
let darkGrayBasic = Color(red: 88 / 255, green: 104 / 255, blue: 138 / 255)
let lightGrayBasic = Color(red: 156 / 255, green: 171 / 255, blue: 210 / 255)
