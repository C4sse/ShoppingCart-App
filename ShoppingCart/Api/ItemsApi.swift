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
import FirebaseStorage

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
                    
                    realmCategory.addCategory(id: category.key, image: (dict["image"] as? String)!, name: (dict["name"] as? String)!, filters: filters)
                }
            }
            
            completion()
        }
    }
    
    static func getItems(forCategoryId categoryId: String, realManager: RealmManager, completion: @escaping () -> Void) {
        
        print(categoryId)
        
        Database.database().reference().child("categoryItems").child(categoryId).observe(.value) { snap in
            
            guard let items = (snap.children.allObjects as? [DataSnapshot]) else {
                return
            }
            
            items.forEach { item in
                print(item)
                
                Database.database().reference().child("products").child(item.key).observe(.value) { snapshot in
                    
                    guard let dict = snapshot.value as? [String: Any] else {
                        return
                    }
                    
                    print(items.count)
                    
                    print(item)
                    
                    realManager.addItem(dict: dict, key: snapshot.key)
                    
                    completion()
                }
            }
        }
    }
    
    static func getDiscountedItems(realManager: RealmManager, completion: @escaping () -> Void) {
        
        Database.database().reference().child("discountItems").observe(.value) { snap in
            
            guard let items = (snap.children.allObjects as? [DataSnapshot]) else {
                return
            }
            
            items.forEach { item in
                
                Database.database().reference().child("products").child(item.key).observe(.value) { snapshot in
                    
                    guard let dict = snapshot.value as? [String: Any] else {
                        return
                    }
                    
                    realManager.addItem(dict: dict, key: snapshot.key)
                    
                    completion()
                }
            }
        }
    }
    
    // MARK: uploading
    static func addProductToStore(dict: [String: Any], forCategoryId categoryId: String, isDiscounted: Bool) {
        
        guard let newId = Database.database().reference().child("products").childByAutoId().key else { return }
        
        Database.database().reference().child("products").child(newId).setValue(dict) { error, ref in
            
            if error != nil {
                
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            
            Database.database().reference().child("categoryItems").child(categoryId).child(newId).setValue(true)
            
            if isDiscounted {
                Database.database().reference().child("discountItems").child(newId).setValue(true)
            }
        }
    }
    
    static func uploadImageToFirebaseStorage(data: Data, onSuccess: @escaping (_ imageUrl: String) -> Void) {
        
        let photoIdString = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("products").child(photoIdString)
        
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
                
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
                if let photoUrl = url?.absoluteString { onSuccess(photoUrl) }
            })
        }
    }
}
