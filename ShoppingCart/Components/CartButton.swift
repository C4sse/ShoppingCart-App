//
//  CartButton.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI

struct CartButton: View {
    var numberOfProducts: Int
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .padding(.top, 5)
            
            if numberOfProducts > 0 {
                Text("\(numberOfProducts)")
                    .font(Font.custom("SFProDisplay-Regular", size: 10))
                    .foregroundColor(backgroundColor3)
                    .frame(width: 15, height: 15)
                    .background(redAccent)
                    .cornerRadius(50)
            }
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton(numberOfProducts: 1)
    }
}
