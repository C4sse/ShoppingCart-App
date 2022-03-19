//
//  ProductCardView.swift
//  ShoppingCart
//
//  Created by George Nhari on 10/3/2022.
//

import SwiftUI

struct ProductCardView: View {
    
    var width: CGFloat
    @State private var showingSheet = false
    @EnvironmentObject var cartManager: CartManager
    @State var isAdded : Bool = false
    var product: Product
    @State var count: Int = 1
    var showDiscount: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(alignment: .leading) {
                
                VStack {
                    
                    Image(product.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: 200)
                        .clipped()
                }
                .frame(width: width, height: 200)
                
                Text("\(product.name)")
                    .bold()
                    .font(Font.title3)
                    .padding(.bottom, 5)
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                
                
                Text("1 kg / $\(product.price, specifier: "%.2f")")
                    .font(.system(size: 13))
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                
                HStack(alignment: .center) {
                    
                    if !isAdded {
                        
                        Text("\(product.price * Double(count), specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                            .padding(.top, 5)
                            .padding(.leading, 12)
                            .padding(.trailing, 1)
                        
                        Spacer(minLength: 25)
                        
                        Button(action: {
                            
                            isAdded.toggle()
                            if !isAdded {
                                var product = product
                                product.addedToCart = false
                                cartManager.removeFromCart(product: product)
                            } else {
                                
                                var product = product
                                product.addedToCart = true
                                cartManager.addToCart(product: product)
                            }
                        }) {
                            Image(systemName: isAdded == true ?  "checkmark" : "cart")
                                .padding(7)
                            
                                .frame(width: 40, height: 40)
                        }
                        .foregroundColor(backgroundColor3)
                        .background(Color.green)
                        .cornerRadius(10.0)
                        .padding(.trailing, 10)
                        
                        
                    } else {
                        
                            Button(action: {
                                
                                count = cartManager.removeQuantity(product: product)
                            }) {
                                Image(systemName: "minus")
                                    .foregroundColor(darkGrayBasic)
                                //                        .padding(.all, 13)
                                    .padding(.bottom, 10)
                                    .padding(.top, 11 )
                                    .padding(.leading, 4)
                                    .padding(.trailing, 4)
                                    .background(backgroundColor1)
                                    .cornerRadius(6.0)
                                
                            }
                            .padding(.leading)
                        Spacer()
                            
                            VStack(alignment: .center) {
                                Text("\(product.price * Double(count), specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                                    .bold()
                                Text("\(count)")
                                    .brightness(0.4)
                                    .font(.subheadline)
                            }
                            .padding(.all, 5)
                            
                        Spacer()
                        
                            Button(action: {
                                count = cartManager.incrQuantity(product: product)
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(darkGrayBasic)
                                    .padding(.all, 4)
                                    .background(backgroundColor1)
                                    .cornerRadius(6.0)
                            }
                            .padding(.trailing)
                    }
                }
                .padding(.bottom, 12)
            }
            
            if showDiscount {
                
                Text("-20%")
                    .foregroundColor(backgroundColor3)
                    .font(.system(size: 13))
                    .bold()
                    .padding(6)
                    .background(redAccent)
                    .cornerRadius(12, corners: [.bottomLeft, .topRight])
            }
        }
        .frame(width: width)
        .sheet(isPresented: $showingSheet) {
            
            DetailScreen(product: product)
                .environmentObject(cartManager)
        }
        .onTapGesture {
            self.showingSheet.toggle()
        }
        .background(backgroundColor3)
        .cornerRadius(12)
        .onAppear {
            print("appe", cartManager.checkIfCartState(product: product))
            isAdded = cartManager.checkIfCartState(product: product)
            count = cartManager.checkQuantity(product: product)
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProductCardView(width: 160, product: Product(name: "Strawberry", image: "fruit1", price: 4.99), showDiscount: true)
    }
}
