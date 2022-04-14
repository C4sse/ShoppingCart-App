//
//  ContentView.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI

struct ContentView: View {
    
    var productList = [
        Product(name: "Orange Juice", image: "1", price: 4.99, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Chocolate Ice Cream", image: "2", price: 2.49, category: "ice cream", expirationDate: "10 days", country: "Russia", storageConditions: "freezer"),
        Product(name: "Kiwi Juice", image: "3", price: 4.39,  category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Watermellon Juice", image: "4", price: 2.39,  category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Banana And oats", image: "5", price: 4.79, category: "meal", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Banana Breakfast", image: "6", price: 2.39, category: "meal", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Strawberry Ice cream", image: "7", price: 3.33, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "freezer"),
        Product(name: "Orange", image: "8", price: 1.39, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Mint Ice cream", image: "11", price: 2.21, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "freezer"),
        Product(name: "Banana", image: "12", price: 0.39, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Mixed Flavor", image: "13", price: 2.75, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Blue-berry Flavor", image: "12", price: 2.00, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Strawberry", image: "17", price: 2.99, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Vanilla", image: "19", price: 1.00, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "freezer"),
        Product(name: "Caramel", image: "23", price: 1.00, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Blue-berry Flavor", image: "12", price: 1.00, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Apple Juice", image: "29", price: 3.19, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Tomatoes", image: "20", price: 2.00, category: "vegetables", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Carrot", image: "15", price: 1.10, category: "vegetables", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
        Product(name: "Paper", image: "25", price: 2.00, category: "vegetables", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
    ]
   
    
    @StateObject var cartManager = CartManager()
    
    var body: some View {
        
        TabView {
            
            HomeView(productList: productList)
                .environmentObject(cartManager)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Catalogue")
                }
            
            DiscountView(productList: productList)
                .environmentObject(cartManager)
                .tabItem {
                    Image(systemName: "percent")
                    Text("Discount")
                }
            
            CartView()
                .environmentObject(cartManager)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
