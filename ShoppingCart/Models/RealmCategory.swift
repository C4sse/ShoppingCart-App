//
//  RealmCategory.swift
//  ShoppingCart
//
//  Created by George Nhari on 17/5/2022.
//

import Foundation
import RealmSwift

class RealmCategory: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var filters: List<String>
}
