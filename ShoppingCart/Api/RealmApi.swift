//
//  RealmApi.swift
//  ShoppingCart
//
//  Created by George Nhari on 24/4/2022.
//
//
//import Foundation
//import Combine
//import RealmSwift
//
//final class RealmApi: ObservableObject {
//
////    @Published var products: [Product] = []
//
//    private var token: NotificationToken?
//
//    init() {
//        setupObserver()
//    }
//
//    deinit {
//        token?.invalidate()
//    }
//
//    private func setupObserver() {
//
//        do {
//            let realm = try Realm()
//            let results = realm.objects(RealmProduct.self)
//
//            token = results.observe({ [weak self] changes in
//                print("change")
////                self?.products = []
////                self?.products = results.map(Product.init)
////                    .sorted(by: { $0.name > $1.name })
//
//            })
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    func addProduct(title: String, image: String, price: Double, category: String, expirationDate: String, country: String, storageConditions: String) {
//
//        let realmProduct = RealmProduct(value: [
//            "id": UUID().uuidString,
//            "name": title,
//            "price": 1.00,
//            "image": image,
//            "category": category,
//            "expirationDate": expirationDate,
//            "country": country,
//            "storageConditions": storageConditions
//        ])
//
//        do {
//            let realm = try Realm()
//            try realm.write({
//                realm.add(realmProduct, update: .all)
//            })
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    func addToCart(id: String) {
//        do {
//            let realm = try Realm()
//            let product = realm.object(ofType: RealmProduct.self, forPrimaryKey: id)
//
//            try realm.write({
//                product?.addedToCart = true
////                setupObserver()
//                let results = realm.objects(RealmProduct.self)
////                self.products = results.map(Product.init)
////                    .sorted(by: { $0.name > $1.name })
//
//            })
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    func deleteAll() {
//
//        do {
//            let realm = try Realm()
//
//            try! realm.write {
//                realm.deleteAll()
//            }
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//}
