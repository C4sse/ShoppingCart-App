//
//  CartManager.swift
//  ShoppingCart
//
//  Created by George Nhari on 26/5/2022.
//

import Foundation
import RealmSwift

class CartManager: ObservableObject {
    
    @Published var paymentSuccess = false
    @Published private(set) var total: Double = 0
    @Published var products: [RealmProduct] = []
    private(set) var cartFile: Realm!
    let paymentHandler = PaymentHandler()
    
    init() {
        openRealm()
    }
    
    func openRealm() {
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 9,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        
        func inLibraryFolder(fileName: String) -> URL {
            
            return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0], isDirectory: true)
                .appendingPathComponent(fileName)
        }
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        cartFile = try! Realm(fileURL: inLibraryFolder(fileName: "cart.realm"))
    }
    
    func getInCartItems() {
        
        let prods = self.cartFile.objects(RealmProduct.self)
        
        prods.forEach { prod in
            products.append(prod)
        }
        
        ItemsApi.getCart(cartManager: self) { [self] in
            
            let prods = self.cartFile.objects(RealmProduct.self)
            
            products = []
            
            prods.forEach { prod in
                products.append(prod)
            }
        }
    }
    
    func write(dict: [String: Any], key: String) {
        if let cartFile = cartFile { // Need to unwrap optional, since localRealm is optional
            do {
                // Trying to write to the localRealm
                try cartFile.write {
                    // Creating a new local database entry
                    
                    let realmProduct = RealmProduct()
                    
                    realmProduct.id = key
                    if let name = dict["name"] as? String { realmProduct.name = name }
                    if let price = dict["price"] as? Double { realmProduct.price = price }
                    if let image = dict["image"] as? String { realmProduct.image = image }
                    if let type = dict["type"] as? String { realmProduct.type = type }
                    if let isDiscounted = dict["isDiscounted"] as? Bool { realmProduct.isDiscounted = isDiscounted }
                    
                    // Adding newTask to localRealm
                    cartFile.add(realmProduct, update: .all)
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
}

