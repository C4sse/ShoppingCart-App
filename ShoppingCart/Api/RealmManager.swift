//
//  RealmManager.swift
//  ToDo
//
//  Created by Stephanie Diep on 2021-12-07.
//

import Foundation
import RealmSwift
import ProgressHUD

class RealmManager: ObservableObject {
    
    let paymentHandler = PaymentHandler()
    
    private(set) var productsFile: Realm!
    @Published var paymentSuccess = false
    @Published private(set) var total: Double = 0
    @Published var products: [RealmProduct] = []
    
    // On initialize of the class, we'll open a Realm and get the tasks saved in the Realm
    init() {
        openRealm()
    }

    // Function to open a Realm (like a box) - needed for saving data inside of the Realm
    func openRealm() {
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 8,
            
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
        
        productsFile = try! Realm(fileURL: inLibraryFolder(fileName: "items.realm"))
    }
    
    func getitems(categoryId: String) {
        
        let predicate = NSPredicate(format: "category = %@", categoryId)
        let prods = self.productsFile.objects(RealmProduct.self)
        
        prods.forEach { prod in
            products.append(prod)
        }
        
        ItemsApi.getItems(forCategoryId: categoryId, realManager: self) { [self] in
            
            let predicate = NSPredicate(format: "category = %@", categoryId)
            let prods = self.productsFile.objects(RealmProduct.self)
            print(prods.count)
            
            products = []
            
            prods.forEach { prod in
                products.append(prod)
            }
        }
    }
    
    func addItem(dict: [String: Any], key: String) {
        if let localRealm = productsFile { // Need to unwrap optional, since localRealm is optional
            do {
                // Trying to write to the localRealm
                try localRealm.write {
                    // Creating a new local database entry
                    
                    let realmProduct = RealmProduct()
                    
                    realmProduct.id = key
                    if let name = dict["name"] as? String { realmProduct.name = name }
                    if let price = dict["price"] as? Double { realmProduct.price = price }
                    if let image = dict["image"] as? String { realmProduct.image = image }
                    if let type = dict["type"] as? String { realmProduct.type = type }
                    
                    // Adding newTask to localRealm
                    localRealm.add(realmProduct, update: .all)
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }

    // Function to update a task's completed state
    func addToCart(id: String, isAdded: Bool) {
        
        if let productsFile = productsFile {
            do {
                // Find the task we want to update by its id
                let productToUpdate = productsFile.objects(RealmProduct.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToUpdate array isn't empty
                guard !productToUpdate.isEmpty else { return }

                // Trying to write to the localRealm
                try productsFile.write {
                    
                    // Getting the first item of the array and changing its completed state
                    productToUpdate[0].addedToCart = isAdded
                    
                    // Re-setting the tasks array
//                    getTasks()
                    print("Updated task with id \(id)! Completed status: \(isAdded)")
                }
                
                // perform network call
                
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    // Function to update a task's completed state
    func addQuantity(id: String) {
        
        
        if let localRealm = productsFile {
            do {
                // Find the task we want to update by its id
                let taskToUpdate = localRealm.objects(RealmProduct.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToUpdate array isn't empty
                guard !taskToUpdate.isEmpty else { return }
                
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    if taskToUpdate[0].cartQuantity< taskToUpdate[0].availableQuantity {
                        
                        // Getting the first item of the array and changing its completed state
                        taskToUpdate[0].cartQuantity = (taskToUpdate[0].cartQuantity) + 1
                        
                        // Re-setting the tasks array
//                        getTasks()
                        calculateTotal()
                        print("Updated task with id \(id)!")
                    } else {
                        
                        ProgressHUD.showFailed("That's all thats available")
                    }
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    // Function to update a task's completed state
    func subtractQuantity(id: String) {
        if let localRealm = productsFile {
            do {
                // Find the task we want to update by its id
                let taskToUpdate = localRealm.objects(RealmProduct.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToUpdate array isn't empty
                guard !taskToUpdate.isEmpty else { return }

                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Getting the first item of the array and changing its completed state
                    taskToUpdate[0].cartQuantity = (taskToUpdate[0].cartQuantity) - 1
                    
                    // Re-setting the tasks array
//                    getTasks()
                    calculateTotal()
                    print("Updated task with id \(id)!")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }

    // Function to delete a task
    func deleteTask(id: String) {
        if let localRealm = productsFile {
            do {
                // Find the task we want to delete by its id
                let taskToDelete = localRealm.objects(RealmProduct.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToDelete array isn't empty
                guard !taskToDelete.isEmpty else { return }
                
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Deleting the task
                    localRealm.delete(taskToDelete)
                    
                    // Re-setting the tasks array
//                    getTasks()
                    print("Deleted task with id \(id)")
                }
            } catch {
                print("Error deleting task \(id) to Realm: \(error)")
            }
        }
    }
    
    // Function to delete a task
    func deleteAll() {
        
        if let localRealm = productsFile {
            do {
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Deleting the task
                    localRealm.deleteAll()
                    
                    // Re-setting the tasks array
//                    getTasks()
                    
                }
                
            } catch {
                print("Error deleting all  to Realm: \(error)")
            }
        }
    }
    
    // MARK: cart manager
    func pay() {
//        paymentHandler.startPayment(products: inCartProducts, total: total) { success in
//            self.paymentSuccess = success
////            self.products = []
//            self.total = 0
//        }
    }
    
    private func calculateTotal() {

        var t = 0.0

        products.forEach { prod in

            t += prod.price * Double(prod.cartQuantity)
        }

        total = t
    }
}


