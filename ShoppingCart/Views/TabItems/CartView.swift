//
//  CartView.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        if true {

                            Text("Thanks for your purchase! Your order will be shipped shortly, You'll also receive email confirmation shortly, with a tracking ID.")
                                .font(Font.custom("SFProText-Light", size: 16))
                                .padding()
                        } else {
                            VStack (alignment: .leading) {
                                HStack {

                                    Text("Items in cart: ")
                                        .font(Font.custom("SFProText-Medium", size: 16))
                                        .foregroundColor(blackBasic)
                                        .padding(.leading, 18)
//                                    Text("\(realmManager.inCartProducts.count)")
//                                        .font(Font.custom("SFProText-Semibold", size: 16))
//                                        .foregroundColor(greenBasic)
                                }
                            }

                            if realmManager.products.count > 0 {

                                ForEach(realmManager.products, id: \.id) { product in

//                                    ProductRow(product: product, count: realmManager.inCartProducts.count)
//                                        .cornerRadius(10)
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
//                    if realmManager.paymentSuccess {
//                        realmManager.paymentSuccess = false
//                    }
                }
                .background(backgroundColor1)
                
                
                HStack(alignment: .center) {
                    
                    VStack(alignment: .leading) {
                        Text("Your Cart total is:")
                            .font(Font.custom("SFProText-Semibold", size: 17))
                        
//                        Text("$ \(realmManager.total, specifier:
                        
                    }
                    .padding(.all, 5)
                    
                    Spacer()
                    
                    PaymentButton(action: {
//                        realmManager.pay()
                    })
                }
                
                .padding()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//            .environmentObject(RealmManager())
//    }
//}
