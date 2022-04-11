//
//  DiscountView.swift
//  ShoppingCart
//
//  Created by George Nhari on 4/3/2022.
//

import SwiftUI

struct DiscountView: View {
    
    @EnvironmentObject var cartManager: CartManager
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 8)]
    var productList: [Product]
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 16) {
                        
                        ForEach(productList, id: \.id) { product in
                            
                            PromotedCard(width: UIScreen.main.bounds.size.width - 30, product: product)
                            
                        }
                        
                    }
                    .offset(x: 16)
                    
                }
                
                Text("More items")
                    .font(.system(size: 22))
                    .bold()
                    .padding(.top, 16.0)
                    .frame(width: UIScreen.main.bounds.size.width - 30, alignment: .leading)
                    .offset(y: 10)
                    
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(productList, id: \.id) { product in
                            ProductCardView(width: getItemWidth(), product: product, showDiscount: true)
                            .environmentObject(cartManager)
                        }
                    }
                }
                .padding()
                
                Text("Deals")
                    .font(.system(size: 22))
                    .bold()
                    .padding(.top, 16.0)
                    .frame(width: UIScreen.main.bounds.size.width - 30, alignment: .leading)
                    .offset(y: 10)
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(productList, id: \.id) { product in
                        ProductCardView(width: getItemWidth(), product: product, showDiscount: true)
                        .environmentObject(cartManager)
                    }
                }
                .padding()
                
                
            }
            .navigationTitle(Text("ShoppingCart"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    
                    CartButton(numberOfProducts: cartManager.products.count)
                }
            }
            .background(backgroundColor1)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            print("appeared")
        }
    }
        
}
    

struct DiscountView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let productList = [Product(name: "Mixed Flavor", image: "13", price: 2.75, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
                           Product(name: "Blue-berry Flavor", image: "12", price: 2.00, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
                           Product(name: "Strawberry", image: "17", price: 2.99, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")]
        
        DiscountView(productList: productList)
    }
}
