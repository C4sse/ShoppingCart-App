//
//  Product.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import Foundation

struct Product: Identifiable {
    
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [Product(name: "Orange sweater", image: "sweater1", price: 34),
                   Product(name: "Red wine sweater", image: "sweater2", price: 24),
                   Product(name: "Sand Sweater", image: "sweater3", price: 33),
                   Product(name: "Sea sweater", image: "sweater4", price: 34),
                   Product(name: "Cream sweater", image: "sweater5", price: 31),
                   Product(name: "Beige sweater", image: "sweater6", price: 29),
                   Product(name: "Grey sweater", image: "sweater7", price: 27),
                   Product(name: "Mink sweater", image: "sweater8", price: 26)]
