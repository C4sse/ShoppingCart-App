//
//  HomeView.swift
//  ShoppingCart
//
//  Created by George Nhari on 4/3/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var search: String = ""
    @State private var selectedIndex: Int = 0
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 12)]
    private let categories = ["all", "juice", "dessert", "meal", "vegetables"]
    
    @State private var showingSheet = false
    @EnvironmentObject var cartManager: CartManager
    var productList: [Product]
    @State var t: [Product] = []
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                VStack (alignment: .leading) {
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 12) {
                            
                            ForEach ( 0 ..< categories.count) { i in
                               
                                Button(action: {selectedIndex = i}) {
                                    
                                    CategoryView(isActive: selectedIndex == i, text: categories[i])
                                }
                            }
                        }
                        .padding()
                    }
                    
                    LazyVGrid(columns: columns, spacing: 12) {
                        
                        ForEach(getItems(), id: \.id) { product in
                            
                            ProductCardView(width: getItemWidth(), product: product, showDiscount: false)
                                .environmentObject(cartManager)
                        }
                    }
                    .padding()
                }
            }
            .background(backgroundColor1)
            .navigationTitle(Text("Home"))
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    
                    CartButton(numberOfProducts: cartManager.products.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getItems() -> [Product] {
        
        if selectedIndex == 0 {
            return productList
        }
        
        let o = productList.filter { product in
            
            if product.category == categories[selectedIndex] {
                return true
            }
            
            return false
        }
        
        return o
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let productList = [Product(name: "Orange Juice", image: "1", price: 4.99, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
                           Product(name: "Chocolate Ice Cream", image: "2", price: 2.49, category: "ice cream", expirationDate: "10 days", country: "Russia", storageConditions: "freezer"),
                           Product(name: "Kiwi Juice", image: "3", price: 4.39,  category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")]
        HomeView(productList: productList)
            .environmentObject(CartManager())
    }
}

struct CategoryView: View {
    let isActive: Bool
    let text: String
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .frame(alignment: .leading)
                .foregroundColor(isActive ? blackBasic : darkGrayBasic)
                .padding(8)
                .padding(.leading, 4)
                .padding(.trailing, 4)
//                .cornerRadius(16)
                .background(isActive ? greyAccent : backgroundColor1)
                .cornerRadius(20)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isActive ? .white : greyAccent, lineWidth: isActive ? 0 : 2)
//                            .background(.red)
                    )
//                .clipped()
            if (isActive) {
//                Color("Primary")
//                .frame(width: 15, height: 2)
//                .clipShape(Capsule())
            }
        }
        .padding(isActive ? 0 : 0)
        .clipped()
        .cornerRadius(isActive ? 20 : 0)
    }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
        .background(Color.black)
    }
}

struct ContentVieww: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SheetView()
        }
    }
}

func getItemWidth() -> CGFloat {
    
    let screenSize: CGRect = UIScreen.main.bounds
    var width = 185.0
    
    if screenSize.width < 330 {
        width = 130
    } else if screenSize.width > 420 {
            
        width = 180
    }
    
    return width
}
