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
        
        NavigationView {
            
            VStack {
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        if cartManager.paymentSuccess {
                            
                            Text("Thanks for your purchase! Your order will be shipped shortly, You'll also receive email confirmation shortly, with tracking ID.")
                                .font(Font.custom("SFProText-Light", size: 16))
                                .padding()
                        } else {
                            VStack (alignment: .leading) {
                                HStack {
                                    
                                    Text("Items in cart: ")
                                        .font(Font.custom("SFProText-Medium", size: 16))
                                        .foregroundColor(blackBasic)
                                        .padding(.leading, 18)
                                    Text("\(cartManager.products.count)")
                                        .font(Font.custom("SFProText-Semibold", size: 16))
                                        .foregroundColor(greenBasic)
                                }
                            }
                            
                            if cartManager.products.count > 0 {
                                
                                ForEach(cartManager.products, id: \.id) { product in
                                    
                                    ProductRow(product: product, count: product.count)
                                        .cornerRadius(10)
                                }
                                
                            } else {
                                
                                Text("Your cart is empty")
                                    .font(Font.custom("SFProText-Semibold", size: 16))
                                    .frame(width: UIScreen.main.bounds.width)
                            }
                        }
                    }
                }
                .padding(.top)
                .navigationTitle(Text("My Cart"))
                .onDisappear {
                    if cartManager.paymentSuccess {
                        cartManager.paymentSuccess = false
                    }
                }
                .background(backgroundColor1)
                
                
                HStack(alignment: .center) {
                    
                    VStack(alignment: .leading) {
                        Text("Your Cart total is:")
                            .font(Font.custom("SFProText-Semibold", size: 17))
                        
                        Text("$ \(cartManager.total, specifier: "%.2f")")
                            .font(Font.custom("SFProText-Bold", size: 24))
                            .foregroundColor(greenBasic)
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
