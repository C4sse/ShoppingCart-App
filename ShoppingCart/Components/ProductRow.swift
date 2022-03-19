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
    @State private var showing = false
    @State var count: Int
    
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
                    
                    Text("1 kg / $\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(darkGrayBasic)
//                        .padding(.bottom)
//                        .brightness(0.5)
                    
                    HStack(alignment: .center) {
                        
                        Button(action: {
                            count = cartManager.removeQuantity(product: product)
                        }) {
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
                            Text("\(product.count)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .font(.system(size: 9))
                                .frame(width: 20)
                        }
                        .padding(.all, 5)
                        
                        Button(action: {
                            count = cartManager.incrQuantity(product: product)
                            
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(darkGrayBasic)
                                .padding(.all, 3)
                                .background(backgroundColor1)
                                .cornerRadius(5.0)
                        }
                        
                        Spacer()
                        
                        Text("\(product.price * Double(count), specifier: "%.2f")")
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
        ProductRow(product: productList[3], count: 1)
            .environmentObject(CartManager())
    }
}
