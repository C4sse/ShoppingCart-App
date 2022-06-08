////
////  CartManager.swift
////  ShoppingCart
////
////  Created by George Nhari on 27/2/2022.
////

import Foundation
import SwiftUI

class CartManagerr: ObservableObject {

    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Double = 0

    let paymentHandler = PaymentHandler()
    @Published var paymentSuccess = false

    func addToCart(product: Product) {

        products.append(product)
        calculateTotal()

        products.sorted { pro, next in
            return pro.name < next.name
        }
    }

    func removeFromCart(product: Product) {

        products = products.filter { $0.id !=  product.id }
        calculateTotal()
    }

    func incrQuantity(product: Product) -> Int {

        let index = products.firstIndex(where: { $0.name == product.name })!

        products[index].count += 1

        products.sort { pro, next in
            return pro.name < next.name
        }

        calculateTotal()

        return products[index].count
//        var prod = product
//        prod.count = product.count + 1
//        products.append(prod)
    }

    func removeQuantity(product: Product) -> Int {

        let index = products.firstIndex(where: { $0.name == product.name })!

        products[index].count -= 1

        products.sort { pro, next in
            return pro.name < next.name
        }

        calculateTotal()

        return products[index].count
    }

//    func pay() {
//        paymentHandler.startPayment(products: products, total: total) { success in
//            self.paymentSuccess = success
//            self.products = []
//            self.total = 0
//        }
//    }

    func checkIfCartState(product: Product) -> Bool {

        guard let index = products.firstIndex(where: { $0.name == product.name }) else { return false }

        return products[index].addedToCart
    }

    func checkQuantity(product: Product) -> Int {

        guard let index = products.firstIndex(where: { $0.name == product.name }) else { return 1 }

        return products[index].count
    }

    private func calculateTotal() {

        var t = 0.0

        products.forEach { prod in

            t += prod.price * Double(prod.count)
        }

        total = t
    }

    func setOffset(product: Product, value: DragGesture.Value) -> CGFloat  {

        guard let index = products.firstIndex(where: { $0.name == product.name }) else { return 0 }

        products[index].offset = value.translation.width

        return products[index].offset
    }

    func setOffset(product: Product, value: CGFloat) -> CGFloat {

        guard let index = products.firstIndex(where: { $0.name == product.name }) else { return 0 }

        products[index].offset = value
        return products[index].offset
    }

    func setIsSwipped(product: Product, isSwipped: Bool) -> Bool {

        guard let index = products.firstIndex(where: { $0.name == product.name }) else { return false }

        products[index].isSwiped = isSwipped
        return products[index].isSwiped
    }
}
