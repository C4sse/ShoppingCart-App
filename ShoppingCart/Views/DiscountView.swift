//
//  DiscountView.swift
//  ShoppingCart
//
//  Created by George Nhari on 4/3/2022.
//

import SwiftUI

struct DiscountView: View {
    
    @StateObject var cartManager = CartManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 20) {
                        ForEach(0..<17) { _ in
                            
                            PromotedCard(width: UIScreen.main.bounds.size.width - 30)
                            
                        }
                        
                    }.offset(x: 16)
                    
                }
                Text("More items")
                    .font(.system(size: 22))
                    .bold()
                    .padding(.top, 16.0)
                    .frame(width: UIScreen.main.bounds.size.width - 30, alignment: .leading)
                    .offset(y: 10)
                    
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(productList, id: \.id) { product in
                        ProductCard(product: product)
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct DiscountView_Previews: PreviewProvider {
    static var previews: some View {
        DiscountView()
    }
}
