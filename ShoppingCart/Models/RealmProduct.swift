//
//  Task.swift
//  ToDo
//
//  Created by Stephanie Diep on 2021-12-07.
//

import Foundation
import RealmSwift

class RealmProduct: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String // This is our primary key, and each Task instance can be uniquely identified by the ID
    @Persisted var title = ""
    @Persisted var completed = false
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var price: Double
    @Persisted var addedToCart: Bool = false
    @Persisted var cartQuantity: Int = 1
    @Persisted var availableQuantity: Int = 7
    @Persisted var offset: Float = 0
    @Persisted var isSwiped: Bool = false
    @Persisted var category: String = ""
    @Persisted var expirationDate: String
    @Persisted var country: String
    @Persisted var storageConditions: String
}
