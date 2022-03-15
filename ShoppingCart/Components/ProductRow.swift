//
//  ProductRow.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        ZStack {
            HStack(alignment: .top,spacing: 20) {
                
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(product.name)
                        .bold()
                    
                    Text("1 kg / $198.00 ")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(darkGrayBasic)
//                        .padding(.bottom)
//                        .brightness(0.5)
                    
                    HStack(alignment: .center) {
                        
                        Button(action: {}) {
                            Image(systemName: "minus")
                                .foregroundColor(darkGrayBasic)
                            //                        .padding(.all, 13)
                                .padding(.bottom, 10)
                                .padding(.top, 10)
                                .padding(.leading, 3)
                                .padding(.trailing, 3)
                                .background(backgroundColor1)
                                .cornerRadius(5.0)
                            
                        }
                        
                        VStack(alignment: .center) {
                            Text("1 item/s")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .font(.system(size: 9))
                                .frame(width: 60)
                        }
                        .padding(.all, 5)
                        
                        Button(action: {}) {
                            Image(systemName: "plus")
                                .foregroundColor(darkGrayBasic)
                                .padding(.all, 3)
                                .background(backgroundColor1)
                                .cornerRadius(5.0)
                        }
                        
                        Spacer()
                        
                        Text("$1399")
                            .font(.title3)
                            .foregroundColor(.green)
                            .font(.system(size: 10))
                            .bold()
                            .offset(x: 30)
                        
                    }
                }
                
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 13,height: 13)
                    .foregroundColor(darkGrayBasic)
//                    .padding(.top)
                    .onTapGesture {
                        cartManager.removeFromCart(product: product)
                    }
                //            VStack(alignment: .trailing, spacing: 40) {
                //
                //            Text("$1399")
                //                .font(.title3)
                //                .foregroundColor(.green)
                //                .font(.system(size: 10))
                //                .bold()
                //            }
            }
            
            
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor3)
        }
        .cornerRadius(20)
        .padding(.leading)
        .padding(.trailing)
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: productList[3])
            .environmentObject(CartManager())
    }
}
