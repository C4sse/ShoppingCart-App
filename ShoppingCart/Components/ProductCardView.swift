//
//  ProductCardView.swift
//  ShoppingCart
//
//  Created by George Nhari on 10/3/2022.
//

import SwiftUI

struct ProductCardView: View {
    
    var image: Image
    @State private var showingSheet = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(alignment: .leading) {
                
                VStack {
                    
                    image
                        .resizable()
                        .cornerRadius(20)
                    
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 200)
                        .clipped()
//                        .onTapGesture {
//                            let _ = print("on tap")
//                            
//                        }
                }
                .frame(width: 180, height: 200)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                
                Text("Banana")
                    .bold()
                    .font(Font.title3)
                    .padding(.bottom, 5)
                
                
                Text("1 kr / $12.00")
                //                .font(.system(.title3))
                    .font(.system(size: 13))
                
                HStack(alignment: .center) {
                    Text("$98.99")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .padding(.top, 5)
                    //                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: 30)
                    
                    Button(action: {}) {
                        Image(systemName: "cart")
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
        .frame(width: 180)
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
        ProductCardView(image: Image(systemName: "house"))
    }
}
