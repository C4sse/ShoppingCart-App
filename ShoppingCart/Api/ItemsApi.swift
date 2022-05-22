//
//  FeedApi.swift
//  ShoppingCart
//
//  Created by George Nhari on 16/4/2022.
//

import FirebaseDatabase
import RealmSwift
import CryptoKit
import ProgressHUD

class ItemsApi {
    
    static func getCategories(realmCategory: CategoriesManager, completion: @escaping () -> Void) {
        
        Database.database().reference().child("categories").observe(.value) { snapshot in
            
            guard let categories = (snapshot.children.allObjects as? [DataSnapshot]) else {
                return
            }
            
            categories.forEach { category in
                
                if let dict = category.value as? [String: Any] {
                    
                    let r = dict["filter"] as? [String: Bool]
                    
                    var filters: [String] = []
                    
                    r?.keys.forEach({ key in
                        filters.append(key)
                    })
                    
                    filters = filters.sorted { $0 < $1 }
                    
                    realmCategory.addCategory(id: category.key, image: (dict["name"] as? String)!, name: (dict["name"] as? String)!, filters: filters)
                }
            }
            
            completion()
        }
    }
    
    static func getItems(forCategoryId categoryId: String, realManager: RealmManager, completion: @escaping () -> Void) {
        
        Database.database().reference().child("products").observe(.value) { snapshot in
            
            guard let items = (snapshot.children.allObjects as? [DataSnapshot]) else {
                return
            }
            print(items.count)
            items.forEach { item in
                print(item)
                if let dict = item.value as? [String: Any] {
                    
                    realManager.addItem(dict: dict, key: item.key)
                }
            }
            
            completion()
        }
    }
    
    // MARK: uploading
    static func addProductToStore(dict: [String: Any], forCategoryId categoryId: String) {
        
        guard let newId = Database.database().reference().child("products").childByAutoId().key else { return }
        
        Database.database().reference().child("products").child(newId).setValue(dict) { error, ref in
            
            if error != nil {
                
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            
            Database.database().reference().child("categoryItems").child(categoryId).child(newId).setValue(true)
        }
    }
}
