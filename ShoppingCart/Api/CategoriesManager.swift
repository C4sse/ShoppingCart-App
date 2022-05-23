//
//  CategoriesManager.swift
//  ShoppingCart
//
//  Created by George Nhari on 17/5/2022.
//

import Foundation
import RealmSwift
import ProgressHUD

class CategoriesManager: ObservableObject {
    
    private(set) var categoriesFile: Realm!
    @Published var categories: [RealmCategory] = []
    
    init() {
        openRealm()
//        getTasks()
    }
    
    // Function to open a Realm (like a box) - needed for saving data inside of the Realm
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
        
        categoriesFile = try! Realm(fileURL: inLibraryFolder(fileName: "categories.realm"))
    }
    
    // Function to add a task
    func addCategory(id: String, image: String, name: String, filters: [String]) {
        if let localRealm = categoriesFile {
            do {
                // Trying to write to the localRealm
                try localRealm.write {
                    // Creating a new Task
                    let realmProduct = RealmCategory(value: [
                        "id": id,
                        "name": name,
                        "image": image,
                        "filters": filters
                    ])
                    
                    // Adding newTask to localRealm
                    localRealm.add(realmProduct, update: .all)
                    
                    // Re-setting the tasks array
//                    getTasks()
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    func getCategories(categoriesManager: CategoriesManager) {
        
        ItemsApi.getCategories(realmCategory: categoriesManager) { [self] in
            print("here")
            let cats = self.categoriesFile.objects(RealmCategory.self)
            print(cats[0].name)
            
            cats.forEach { cat in
                categories.append(cat)
            }
        }
    }
    
//    // Function to get all tasks from Realm and setting them in the tasks array
//    func getTasks() {
//
//        if let productsFile = categoriesFile {
//
//            // Getting all objects from localRealm and sorting them by completed state
//            categories = productsFile.objects(RealmCategory.self)
//
//        }
//    }
}
