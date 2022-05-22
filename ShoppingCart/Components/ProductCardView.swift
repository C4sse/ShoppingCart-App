//
//  ProductCardView.swift
//  ShoppingCart
//
//  Created by George Nhari on 10/3/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCardView: View {
    
    var width: CGFloat
    @State private var showingSheet = false
//    @EnvironmentObject var cartManager: CartManager
//    @State var isAdded : Bool = false
    @EnvironmentObject var realmManager: RealmManager
    @State var product: RealmProduct
    @State var count: Int = 1
    var showDiscount: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    VStack {
                        
                        WebImage(url: URL(string: product.image))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: 200)
                            .clipped()
                    }
                    .frame(width: width, height: 200)
                    
                    Text("\(product.name)")
                        .font(Font.custom("SFProText-Bold", size: 19))
                        .padding(.bottom, 1)
                        .padding(.leading, 12)
                        .padding(.trailing, 8)
                        .lineLimit(1)
                    
                    Text("1 kg / $\(product.price, specifier: "%.2f")")
                        .font(Font.custom("SFProText-Regular", size: 13))
                        .foregroundColor(darkGrayBasic)
                        .padding(.leading, 12)
                        .padding(.trailing, 8)
                        .padding(.top, 8)
                }
                .background(backgroundColor3)
                .onTapGesture {
                    self.showingSheet.toggle()
                }
                
                HStack(alignment: .center) {
                    
                    if !product.addedToCart {
                        
                        VStack(alignment: .leading) {
                            
                            if showDiscount {
                                
                                Text("$ \(product.price + 3, specifier: "%.2f")")
                                    .strikethrough(true)
                                    .font(Font.custom("SFProText-Regular", size: 13))
                                    .foregroundColor(lightGrayBasic)
                                    
                            }
                            
                            Text("$ \(product.price * Double(count), specifier: "%.2f")")
                                .font(Font.custom("SFProDisplay-Bold", size: 19))
                                .foregroundColor(greenBasic)
                                .padding(.top, 0)
                                .padding(.leading, 0)
                        }
                        .padding(.leading, 12)
                        .padding(.top, 3)
                        
                        Spacer()
                        
                        Button(action: {
                            realmManager.addToCart(id: product.id, isAdded: !product.addedToCart)
                        }) {
                            Image(systemName: product.addedToCart == true ?  "checkmark" : "cart")
                                .padding(7)
                            
                                .frame(width: 40, height: 40)
                        }
                        .foregroundColor(backgroundColor3)
                        .background(greenBasic)
                        .cornerRadius(10.0)
                        .padding(.trailing, 10)
                        
                        
                    } else {
                        
                            Button(action: {
                                
                                realmManager.subtractQuantity(id: product.id)
                            }) {
                                Image(systemName: "minus")
                                    .foregroundColor(product.cartQuantity < 2 ? lightGrayBasic : darkGrayBasic)
                                //                        .padding(.all, 13)
                                    .padding(.bottom, 10)
                                    .padding(.top, 11 )
                                    .padding(.leading, 4)
                                    .padding(.trailing, 4)
                                    .background(backgroundColor1)
                                    .cornerRadius(6.0)
                                
                            }
                            .disabled(product.cartQuantity < 2 ? true : false)
                            
                            .padding(.leading)
                        Spacer()
                            
                            VStack(alignment: .center) {
                                Text("$ \(product.price * Double(count), specifier: "%.2f")")
                                    .font(Font.custom("SFProText-Bold", size: 16))
                                    .foregroundColor(greenBasic)
                                Text("\(product.cartQuantity)")
                                    .brightness(0.4)
                                    .font(Font.custom("SFProText-Regular", size: 13))
                            }
                            
                        Spacer()
                        
                            Button(action: {
                                realmManager.addQuantity(id: product.id)
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
                    .font(Font.custom("SFProText-Bold", size: 13))
                    .foregroundColor(backgroundColor3)
                    .padding(6)
                    .background(redAccent)
                    .cornerRadius(12, corners: [.bottomLeft, .topRight])
            }
        }
        .frame(width: width)
        .sheet(isPresented: $showingSheet) {
            
            DetailScreen(product: product)
                .environmentObject(realmManager)
        }
        .background(backgroundColor3)
        .cornerRadius(12)
    }
}

//struct ProductCardView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        ProductCardView(width: 160, product: Product(name: "Strawberry", image: "17", price: 2.99, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"), showDiscount: true)
//            .environmentObject(CartManager())
//    }
//}
