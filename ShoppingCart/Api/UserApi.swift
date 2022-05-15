//
//  UserApi.swift
//  ShoppingCart
//
//  Created by George Nhari on 16/4/2022.
//

import FirebaseDatabase
import FirebaseAuth
import RealmSwift

class UserApi {
    
    //MARK: - User by uid
//    func observeCurrentUserFromDisk(onSuccess: @escaping (RealmUser) -> Void) {
//
//        guard let uid = Api.User.CURRENT_USER?.uid else { return }
//        observeUserFromDisk(withUid: uid) { (user) in
//            onSuccess(user)
//        } onFailure: {
//            
//        }
//    }
//
//    func observeCurrentUserToDisk(onSuccess: @escaping () -> Void) {
//
//        guard let uid = Api.User.CURRENT_USER?.uid else { return }
//
//        observeUserToDisk(withUid: uid) {
//            onSuccess()
//        } onFailure: {
//
//        }
//    }
//
//    //MARK: - Current User
//    func observeUserFromDisk(withUid uid: String, realmFile file: Realm = usersOnDisk, onSuccess: @escaping (RealmUser) -> Void, onFailure: @escaping () -> Void) {
//
//        let predicate = NSPredicate(format: "id = %@", uid)
//        var users: Results<RealmUser>!
//        users = file.objects(RealmUser.self).filter(predicate)
//
//        if let index = users.index(matching: predicate) {
//
//            let user = users[index]
//            onSuccess(user)
//
//        } else {
//            observeUserToDisk(withUid: uid, realmFile: file, onSuccess: {
//
//                self.observeUserFromDisk(withUid: uid, realmFile: file) { (user) in
//                    onSuccess(user)
//                } onFailure: {
//
//                    onFailure()
//                }
//            }, onFailure: {
//
//                onFailure()
//            })
//        }
//    }
//
//    func observeUserToDisk(withUid uid: String, realmFile file: Realm = usersOnDisk, onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void) {
//
//        Config.REF_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//
//            if snapshot.exists() {
//
//                if var dict = snapshot.value as? [String: Any] {
//
//                    Api.Follow.isFollowing(userId: uid) { (bool) in
//
//                        dict[dict_isFollowing] = bool
//
//                        Api.Block.hasBlockedUser(uid: uid) { (blockedMe) in
//
//                            dict[dict_hasBlockedUser] = blockedMe
//
//                            Api.Block.isBlockedWith(uid: uid) { (isBlocked) in
//
//                                dict[dict_isBlocked] = isBlocked
//
//                                let user = UserModel.transformUser(dict: dict, key: snapshot.key)
//
//                                RealmUser.writeUser(user, toFile: file)
//                                onSuccess()
//                            }
//                        }
//                    }
//                }
//            } else {
//
//                onFailure()
//            }
//        })
//    }
    
//    func queryUsers(withText text: String, completion: @escaping ([UserModel]) -> Void) {
//
//        Config.REF_USERS.queryOrdered(byChild: dict_usernameLowercase).queryStarting(atValue: text)
//            .queryEnding(atValue: text+"\u{f8ff}").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: { (snapshot) in
//
//                var users = [UserModel]()
//
//                snapshot.children.forEach({ (s) in
//
//                    let child = s as! DataSnapshot
//
//                    if let dict = child.value as? [String: Any] {
//
//                        let user = UserModel.transformUser(dict: dict, key: child.key)
//
//                        if user.id! != Api.User.CURRENT_USER?.uid {
//
//                            users.append(user)
//                        }
//                    }
//                })
//                completion(users)
//            })
//    }
    
    func resetPassword (email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) {(error) in
            if error == nil{
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    var CURRENT_USER: FirebaseAuth.User? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        
        return nil
    }
    
    var REF_CURRENT_USER: DatabaseReference? {
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }
        return Config.REF_USERS.child(currentUser.uid)
    }
}
