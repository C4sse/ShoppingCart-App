//
//  PromotedCard.swift
//  ShoppingCart
//
//  Created by George Nhari on 3/3/2022.
//

import SwiftUI

struct PromotedCard: View {
    
    var width: CGFloat
    @State private var showingSheet = false
    var product: RealmProduct
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            ZStack(alignment: .leading) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: 200)
                    .cornerRadius(20)
                    .brightness(-0.3)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    Text(product.name)
                        .font(Font.custom("SFProDisplay-Bold", size: 24))
                        .foregroundColor(backgroundColor3)
                        .shadow(color: blackBasic, radius: 2.5)
                        .offset(x: 20, y: -35)
                    
                    Text("Description of the thing")
                        .font(Font.custom("SFProDisplay-Regular", size: 16))
                        .frame(alignment: .leading)
                        .foregroundColor(backgroundColor3)
                        .shadow(color: blackBasic, radius: 2.5)
                        .offset(x: 20, y: -25)
                    
                    
                }
            }
            ZStack(alignment: .topTrailing) {
                Text("-20%")
                    .font(Font.custom("SFProDisplay-Semibold", size: 16))
                    .foregroundColor(backgroundColor3)
                    .padding(12)
                    .background(redAccent)
                    .cornerRadius(30, corners: [.bottomLeft, .topRight])

                    
            }
        }
        .sheet(isPresented: $showingSheet) {
//            DetailScreen(product: product)
        }
        .onTapGesture {
            self.showingSheet.toggle()
        }
    }
}

//struct PromotedCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PromotedCard(width: 300, product: Product(name: "Mixed Flavor", image: "13", price: 2.75, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"))
//    }
//}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
