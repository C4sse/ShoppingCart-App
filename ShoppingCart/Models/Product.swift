//
//  Product.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import Foundation
import Combine
import SwiftUI
import RealmSwift

struct Product: Identifiable {

    var id: ObjectId
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

//    init(realmProduct: RealmProduct) {
////        self.id = realmProduct.id
//        self.name = realmProduct.name
//        self.image = realmProduct.image
//        self.price = realmProduct.price
//        self.addedToCart = realmProduct.addedToCart
//        self.count = realmProduct.count
//        self.offset = CGFloat(realmProduct.offset)
//        self.category = realmProduct.category
//        self.expirationDate = realmProduct.expirationDate
//        self.country = realmProduct.country
//        self.storageConditions = realmProduct.storageConditions
//    }
}
//
//class RealmProduct: Object, ObjectKeyIdentifiable {
//
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var name: String
//    @Persisted var image: String
//    @Persisted var price: Double
//    @Persisted var addedToCart: Bool = false
//    @Persisted var count: Int = 1
//    @Persisted var offset: Float = 0
//    @Persisted var isSwiped: Bool = false
//    @Persisted var category: String = ""
//    @Persisted var expirationDate: String
//    @Persisted var country: String
//    @Persisted var storageConditions: String
//
//}
