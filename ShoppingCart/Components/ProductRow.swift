//
//  ProductRow.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var realmManager: RealmManager
    var product: RealmProduct
    @State private var showing = false
    @State var count: Int
    @State var isSwipped: Bool = false
    @State var offset: CGFloat = 0
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: .init(colors: [lightAccent]), startPoint: .leading, endPoint: .trailing)
            
            // delete button
            HStack {
                
                Spacer()
                
                Button {
//                    deleteProduct(product: product)
                } label: {
                    
                    Image(systemName: "trash")
                        .foregroundColor(darkGrayBasic)
                        .frame(width: 90, height: 90)
                }
            }
            
            HStack(alignment: .top,spacing: 20) {
                
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(product.name)
                        .font(Font.custom("SFProText-Semibold", size: 16))
                    
                    Text("1 kg / $ \(product.price, specifier: "%.2f")")
                        .font(Font.custom("SFProText-Regular", size: 11))
                        .foregroundColor(darkGrayBasic)
                    
                    HStack(alignment: .center) {
                        
                        Button(action: {
//                            count = cartManager.removeQuantity(product: product)
                        }) {
                            Image(systemName: "minus")
                                .foregroundColor(darkGrayBasic)
                                .padding(.bottom, 10)
                                .padding(.top, 10)
                                .padding(.leading, 3)
                                .padding(.trailing, 3)
                                .background(backgroundColor1)
                                .cornerRadius(5.0)
                        }
                        
                        VStack(alignment: .center) {
                            Text("\(product.cartQuantity)")
                                .font(Font.custom("SFProText-Regular", size: 15))
                                .foregroundColor(darkGrayBasic)
                                .frame(width: 20)
                        }
                        .padding(.all, 5)
                        
                        Button(action: {
//                            count = cartManager.incrQuantity(product: product)
                            
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(darkGrayBasic)
                                .padding(.all, 3)
                                .background(backgroundColor1)
                                .cornerRadius(5.0)
                        }
                        
                        Spacer()
                        
                        Text("$ \(product.price * Double(count), specifier: "%.2f")")
                            .font(Font.custom("SFProText-Bold", size: 20))
                            .foregroundColor(greenBasic)
                            .offset(x: 30)
                        
                    }
                }
                
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 13,height: 13)
                    .foregroundColor(darkGrayBasic)
//                    .padding(.top)
                    .onTapGesture {
//                        cartManager.removeFromCart(product: product)
                    }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor3)
            .offset(x: offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
        }
        .cornerRadius(20)
        .padding(.leading)
        .padding(.trailing)
    }
    
    func onChanged(value: DragGesture.Value) {
        print("swipping")
        
//        if value.translation.width < 0 {
//
//            if isSwipped {
//                let w = value.translation.width - 90
//                offset = cartManager.setOffset(product: product, value: w)
//            } else {
//                offset = cartManager.setOffset(product: product, value: value)
//            }
//        }
    }
    
    func onEnd(value: DragGesture.Value) {
        print("on end")
//        withAnimation(.easeOut(duration: 0.4)) {
//
//            if value.translation.width < 0 {
//
//                // checking
//
//                if -value.translation.width > UIScreen.main.bounds.width / 3 {
//
////                    withAnimation(.easeOut(duration: 10)) {
//                        offset = cartManager.setOffset(product: product, value: -1000)
//                        cartManager.removeFromCart(product: product)
////                    }
//                } else if -product.offset > 50 {
//                    isSwipped = cartManager.setIsSwipped(product: product, isSwipped: true)
//                    offset = cartManager.setOffset(product: product, value: -90)
//                } else {
//                    isSwipped = cartManager.setIsSwipped(product: product, isSwipped: false)
//                    offset = cartManager.setOffset(product: product, value: 0)
//                }
//            } else {
//
//                isSwipped = cartManager.setIsSwipped(product: product, isSwipped: false)
//                offset = cartManager.setOffset(product: product, value: 0)
//            }
//        }
    }
    
    func deleteProduct(product: Product) {
        
        withAnimation(.easeOut(duration: 0.4)) {
//            offset = cartManager.setOffset(product: product, value: -1000)
//            cartManager.removeFromCart(product: product)
        }
    }
}

//struct ProductRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductRow(product: Product(name: "Strawberry", image: "fruit1", price: 4.99), count: 1)
//            .environmentObject(CartManager())
//    }
//}
