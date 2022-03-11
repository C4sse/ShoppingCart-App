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
    var columns = [GridItem(.adaptive(minimum: getItemWidth()), spacing: 16)]
    private let categories = ["Banana", "Apple", "Grape", "Orange", "Kiwi", "Tomato"]
    
    @State private var showingSheet = false
    @StateObject var cartManager = CartManager()
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                VStack (alignment: .leading) {
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack {
                            
                            ForEach ( 0 ..< categories.count) { i in
                               
                                Button(action: {selectedIndex = i}) {
                                    CategoryView(isActive: selectedIndex == i, text: categories[i])
                                }
                            }
                        }
                        .padding()
                    }
                    
//                    ScrollView (.horizontal, showsIndicators: false) {
//                        HStack (spacing: 0) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(productList, id: \.id) { product in
                                
                                ProductCardView(width: getItemWidth(), product: product)
                                .environmentObject(cartManager)
                                    
//                                NavigationLink(
//                                    destination: DetailScreen(),
//                                    label: {
//                                        ProductCardView(image: Image("fruit\(i)"))
//                                    })
                                    
//                                    .navigationBarHidden(false)
//                                    .foregroundColor(.black)
                                    
                            }
//                            .padding(.leading)
                    }
//                    .padding()
//                        }
//                    }
//                    .padding(.bottom)
                }
            }
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
                .foregroundColor(isActive ? lightGrayBasic : Color.black.opacity(0.5))
//                .padding()
//                .overlay(
//                        RoundedRectangle(cornerRadius: 16)
//                            .stroke(Color("#39B54E"), lineWidth: 4)
//                    )
            if (isActive) {
                Color("Primary")
                .frame(width: 15, height: 2)
                .clipShape(Capsule())
            }
        }
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
    let _ = print(screenSize)
    var width = 160.0
    
    if screenSize.width < 330 {
        width = 130
    } else if screenSize.width > 420 {
            
        width = 180
    }
    
    return width
}
