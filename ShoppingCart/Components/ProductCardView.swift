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
    var showDiscount: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(alignment: .leading) {
                
                VStack {
                    
                    Image(product.image)
                        .resizable()
//                        .cornerRadius(14, corners: [.topLeft, .topRight])
                    
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: 200)
                        .clipped()
                    
//                        .onTapGesture {
//                            let _ = print("on tap")
//                            
//                        }
                }
                .frame(width: width, height: 200)
//                .cornerRadius(20, corners: [.topLeft, .topRight])
                
                Text("\(product.name)")
                    .bold()
                    .font(Font.title3)
                    .padding(.bottom, 5)
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                
                
                Text("1 kg / $12.00")
                    .font(.system(size: 13))
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                
                HStack(alignment: .center) {
                    Text("\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .padding(.top, 5)
                        .padding(.leading, 12)
                        .padding(.trailing, 1)
                    
                    Spacer(minLength: 25)
                    
                    Button(action: {
                        
                        if isAdded {
                            
                            var product = product
                            product.addedToCart = false
                            cartManager.removeFromCart(product: product)
                            isAdded = product.addedToCart
                        } else {
                            
                            var product = product
                            product.addedToCart = true
                            cartManager.addToCart(product: product)
                            isAdded = product.addedToCart
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
            let _ = print("show")
            DetailScreen()
        }
        .onTapGesture {
            self.showingSheet.toggle()
        }
        .background(backgroundColor3)
        .cornerRadius(12)
    }
}

struct ProductCardView_Previews: PreviewProvider {
    let image: Image
    static var previews: some View {
        ProductCardView(width: 160, product: productList[0], showDiscount: true)
    }
}
