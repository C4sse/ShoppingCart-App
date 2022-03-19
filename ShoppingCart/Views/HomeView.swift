//
//  HomeView.swift
//  ShoppingCart
//
//  Created by George Nhari on 4/3/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var search: String = ""
    @State private var selectedIndex: Int = 1
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 8)]
    private let categories = ["Banana", "Apple", "Grape", "Orange", "Kiwi", "Tomato"]
    
    @State private var showingSheet = false
    @EnvironmentObject var cartManager: CartManager
    
    
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
                    
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(productList, id: \.id) { product in
                            
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
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
                .foregroundColor(isActive ? darkGrayBasic : lightGrayBasic)
                .padding(8)
//                .cornerRadius(16)
                .background(isActive ? backgroundColor1 : .white)
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isActive ? .white : lightGrayBasic, lineWidth: isActive ? 0 : 2)
//                            .background(.red)
                    )
            if (isActive) {
//                Color("Primary")
//                .frame(width: 15, height: 2)
//                .clipShape(Capsule())
            }
        }
        .padding(isActive ? 0 : 3)
        .clipped()
        .cornerRadius(isActive ? 16 : 0)
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
