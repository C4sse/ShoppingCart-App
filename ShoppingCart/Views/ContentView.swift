//
//  ContentView.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI

struct ContentView: View {
    
    var productList = [Product(name: "Strawberry", image: "fruit1", price: 4.99),
                       Product(name: "Banana", image: "fruit2", price: 4.99),
                       Product(name: "Nach", image: "fruit3", price: 3.50),
                       Product(name: "Cherry", image: "fruit4", price: 4.99),
                       Product(name: "Cream sweater", image: "sweater5", price: 3.99),
                       Product(name: "Beige sweater", image: "sweater6", price: 9.99),
                       Product(name: "Grey sweater", image: "sweater7", price: 7.45),
                       Product(name: "Mink sweater", image: "sweater8", price: 6.00)]
    
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
