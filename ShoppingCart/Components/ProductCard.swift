//
//  ProductCard.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    @State private var isPresentingOverlay: Bool = false
    @State var isAdded : Bool = false
    
    var body: some View {
        
        NavigationLink {
//            DetailScreen()
        } label: {
            ZStack(alignment: .topTrailing) {
                
                ZStack(alignment: .bottom) {
                    Image(product.image)
                        .resizable()
                        .cornerRadius(20)
                        .frame(width: 180)
                        .scaledToFit()
                    
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .bold()
                        
                        Text("\(product.price)$")
                            .font(.caption)
                    }
                    .padding()
                    .frame(width: 180, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                }
                
                .frame(width: 180, height: 250)
                .shadow(radius: 3)
                
                Button {
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
                } label: {
                    Image(systemName: isAdded == true ? "checkmark" : "plus" )
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(50)
                        .padding()
                }
                
            }
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: productList[0])
            .environmentObject(CartManager())
    }
}
