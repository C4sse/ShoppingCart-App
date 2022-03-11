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
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(alignment: .leading) {
                
                VStack {
                    
                    Image(product.image)
                        .resizable()
                        .cornerRadius(20)
                    
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: 200)
                        .clipped()
//                        .onTapGesture {
//                            let _ = print("on tap")
//                            
//                        }
                }
                .frame(width: width, height: 200)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                
                Text("\(product.name)")
                    .bold()
                    .font(Font.title3)
                    .padding(.bottom, 5)
                
                
                Text("1 kg / $12.00")
                //                .font(.system(.title3))
                    .font(.system(size: 13))
                
                HStack(alignment: .center) {
                    Text("\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .padding(.top, 5)
                    //                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: 30)
                    
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
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10.0)
                    .padding(.trailing, 8)
                }
            }
                Text("-20%")
                    .foregroundColor(.white)
                    .bold()
                    .padding(12)
                    .background(Color.red)
                    .cornerRadius(20, corners: [.bottomLeft, .topRight])

                    
        }
        .frame(width: width)
        .sheet(isPresented: $showingSheet) {
            let _ = print("show")
            DetailScreen()
        }
        .onTapGesture {
            self.showingSheet.toggle()
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    let image: Image
    static var previews: some View {
        ProductCardView(width: 160, product: productList[0])
    }
}
