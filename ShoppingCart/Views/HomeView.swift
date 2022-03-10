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
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    private let categories = ["Banana", "Apple", "Grape", "Orange", "Kiwi", "Tomato"]
    @StateObject var cartManager = CartManager()
    @State private var showingSheet = false
    
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
                    LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(0 ..< 4) { i in
                                
                                ProductCardView(image: Image("fruit\(i)"))
                                    
//                                NavigationLink(
//                                    destination: DetailScreen(),
//                                    label: {
//                                        ProductCardView(image: Image("fruit\(i)"))
//                                    })
                                    
//                                    .navigationBarHidden(false)
//                                    .foregroundColor(.black)
                                    
                            }
                            .padding(.leading)
                    }
                    .padding()
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
        VStack (alignment: .leading, spacing: 0) {
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(isActive ? Color("Primary") : Color.black.opacity(0.5))
            if (isActive) { Color("Primary")
                .frame(width: 15, height: 2)
                .clipShape(Capsule())
            }
        }
        .padding(.trailing)
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
