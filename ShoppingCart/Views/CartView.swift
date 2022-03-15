//
//  CartView.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        
            
            ScrollView {
                VStack {
                    
                    if cartManager.paymentSuccess {
                        
                        Text("Thanks for your purchase! You'll get cozy in our comfy sweaters soon! You'll also receive email confirmation shortly.")
                            .padding()
                    } else {
                        
                        if cartManager.products.count > 0 {
                            
                            ForEach(cartManager.products, id: \.id) { product in
                                
                                ProductRow(product: product)
                                    .cornerRadius(10)
                            }
                            
                        } else {
                            
                            Text("Your cart is empty")
                        }
                    }
                }
                
            }
            .navigationTitle(Text("My Cart"))
            .padding(.top)
            .onDisappear {
                if cartManager.paymentSuccess {
                    cartManager.paymentSuccess = false
                }
            }
            .background(backgroundColor1)
            .navigationViewStyle(StackNavigationViewStyle())
        
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                Text("Your Cart total is:")
                    .bold()
                
                Text("$1399")
                    .font(.title2)
                    .foregroundColor(.green)
                    .bold()
            }
            .padding(.all, 5)
            
            Spacer()
            
            PaymentButton(action: {
                cartManager.pay()
            })
        }
        .padding()
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
