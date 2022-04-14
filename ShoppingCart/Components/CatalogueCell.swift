//
//  CatalogueCell.swift
//  ShoppingCart
//
//  Created by George Nhari on 8/4/2022.
//

import SwiftUI

struct CatalogueCell: View {
    
    var width: CGFloat
    var productType: ProductType
    @State private var showingSheet = false
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            ZStack(alignment: .bottom) {
                
                
                Image(productType.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: 200)
                    .clipped()
                    .brightness(-0.3)
                
                
                VStack(alignment: .leading) {
                    
                    VStack() {}
                    .frame(width: 60, height: 3)
                    .background(backgroundColor3)
                    .cornerRadius(1.5)
                    
                    Text("\(productType.name)")
                        .font(Font.custom("SFProText-Regular", size: 15))
                        .lineLimit(1)
                        .foregroundColor(backgroundColor3)
                        .padding(.top, 0)
                }
                .padding(.bottom, 30)
                .offset(x: -20)
            }
            .frame(width: width, height: 200)
            
        }
        .frame(width: width)
//        .sheet(isPresented: $showingSheet) {
//        
//                    CategoriesView(productType: ProductType(name: "Cookies, Sweetes", image: "cookies", category: ["All", "chocolate"]))
//                        .environmentObject(cartManager)
//        }
//        .onTapGesture {
//            self.showingSheet.toggle()
//        }
        .background(backgroundColor3)
        .cornerRadius(20)
        .onAppear {
//            isAdded = cartManager.checkIfCartState(product: product)
//            count = cartManager.checkQuantity(product: product)
        }
        
    }
}

struct CatalogueCell_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueCell(width: 200, productType: ProductType(name: "Cookies, Sweetes", image: "cookies", category: ["All", "chocolate"]))
    }
}
