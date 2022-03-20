//
//  ContentView.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI

struct ContentView: View {
    
    var productList = [
        Product(name: "Orange Juice", image: "1", price: 4.99, category: "juice"),
        Product(name: "Chocolate Ice Cream", image: "2", price: 2.49, category: "ice cream"),
        Product(name: "Kiwi Juice", image: "3", price: 4.39,  category: "juice"),
        Product(name: "Watermellon Juice", image: "4", price: 2.39,  category: "juice"),
        Product(name: "Banana And oats", image: "5", price: 4.79, category: "meal"),
        Product(name: "Banana Breakfast", image: "6", price: 2.39, category: "meal"),
        Product(name: "Strawberry Ice cream", image: "7", price: 3.33, category: "dessert"),
        Product(name: "Orange", image: "8", price: 1.39, category: "juice"),
        Product(name: "Mint Ice cream", image: "11", price: 2.21, category: "dessert"),
        Product(name: "Banana", image: "12", price: 0.39, category: "juice"),
        Product(name: "Mixed Flavor", image: "13", price: 2.75, category: "dessert"),
        Product(name: "Blue-berry Flavor", image: "12", price: 2.00, category: "dessert"),
        Product(name: "Strawberry", image: "17", price: 2.99, category: "juice"),
        Product(name: "Vanilla", image: "19", price: 1.00, category: "dessert"),
        Product(name: "Caramel", image: "23", price: 1.00, category: "dessert"),
        Product(name: "Blue-berry Flavor", image: "12", price: 1.00, category: "dessert"),
        Product(name: "Apple Juice", image: "29", price: 3.19, category: "juice"),
        Product(name: "Tomatoes", image: "20", price: 2.00, category: "vegetables"),
        Product(name: "Carrot", image: "15", price: 1.10, category: "vegetables"),
        Product(name: "Paper", image: "25", price: 2.00, category: "vegetables"),
    ]
    
    @StateObject var cartManager = CartManager()
    
    var body: some View {
        
        TabView {
            
            HomeView(productList: productList)
                .environmentObject(cartManager)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Home")
                }
            
            DiscountView(productList: productList)
                .environmentObject(cartManager)
                .tabItem {
                    Image(systemName: "percent")
                    Text("Discount")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//import SwiftUI
//
//struct ContentView: View {
//    @StateObject var cartManager = CartManager()
//    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
//
//    var body: some View {
////        NavigationView {
//
////            VStack {
////                Text("hello")
//                ScrollView(.vertical, showsIndicators: true) {
//
//                    ScrollView(.horizontal) {
//                        HStack {
//                            ForEach(0..<17) { _ in
//    //                            ProductCard(product: product)
//    //                                .environmentObject(cartManager)
//                                Image(systemName: "person.fill").resizable().frame(width: 50, height: 50, alignment: .center).foregroundColor(.purple).clipShape(Circle())
//                            }
//
//                        }
//                    }
////                    VStack{
//                        Image("sweater1").resizable().frame(height: 250, alignment: .center)
////                        Image("sweater1").resizable().frame(height: 250, alignment: .center)
////                        Image("sweater1").resizable().frame(height: 250, alignment: .center)
////                        Image("sweater1").resizable().frame(height: 250, alignment: .center)
////                        Image("sweater1").resizable().frame(height: 250, alignment: .center)
////                        Image("sweater1").resizable().frame(height: 250, alignment: .center)
////                    }
////                    .padding()
//                }
//
////                ScrollView(.vertical, showsIndicators: true) {
////                }
////                ScrollView(.vertical) {
//
////                    LazyVGrid(columns: columns, spacing: 20) {
////                        ForEach(productList, id: \.id) { product in
////                            ProductCard(product: product)
////                                .environmentObject(cartManager)
////                        }
////                    }
////                    .padding()
////                }
////            }
////                .navigationTitle(Text("ShoppingCart"))
////                .toolbar {
////                    NavigationLink {
////                        CartView()
////                            .environmentObject(cartManager)
////                    } label: {
////
////                        CartButton(numberOfProducts: cartManager.products.count)
////                    }
////            }
//
////        }
////        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}
