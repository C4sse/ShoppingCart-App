//
//  HomeView.swift
//  ShoppingCart
//
//  Created by George Nhari on 4/3/2022.
//

import SwiftUI
import RealmSwift

struct CategoriesView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @State private var search: String = ""
    @State private var selectedIndex: Int = 0
    @State private var showingSheet = false
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 12)]
    var category: RealmCategory
    @State private var filteredProducts: [RealmProduct] = []
    
    var body: some View {
        
//        HStack(spacing: 12) {
//            // 2
//            TextField("Enter New Task..", text: $taskTitle)
//            // 3
//            Button {
//                print("tapping")
//                realmManager.addTask(title: taskTitle, image: "chair_1", price: 2, category: "hi", expirationDate: "ht", country: "cd", storageConditions: "12")
//                taskTitle = ""
//            } label: {
//                Image(systemName: "plus")
//                    .foregroundColor(.blue)
//            }
//        }
//        .padding(20)
        
        ScrollView(showsIndicators: false) {
            
            VStack (alignment: .leading) {
                
                ScrollView (.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 12) {
                        
                        ForEach (0 ..< category.filters.count, id:\.self) { i in
                            
                            Button(action: {
                                selectedIndex = i
                                if selectedIndex > 0 {
                                    filteredProducts = realmManager.products.filter { $0.type.contains(category.filters[i]) }
                                }
                            }) {
                                
                                CategoryView(isActive: selectedIndex == i, text: category.filters[i])
                            }
                        }
                    }
                    .padding()
                }
                .padding(0)
                .background(backgroundColor1)
                
                LazyVGrid(columns: columns, spacing: 12) {
                    
                    if selectedIndex > 0 {
                        
                        ForEach(filteredProducts, content: { product in
                            
                            if  !product.isInvalidated {
                                
                                ProductCardView(width: getItemWidth(), product: product, showDiscount: false)
                                    .environmentObject(realmManager)
                            }
                        })
                        
                    } else {
                        
                        ForEach(realmManager.products, content: { product in
                            
                            if !product.isInvalidated {
                                
                                ProductCardView(width: getItemWidth(), product: product, showDiscount: false)
                                    .environmentObject(realmManager)
                            }
                        })
                    }
                }
                .padding()
            }
        }
        .background(backgroundColor1)
        .navigationTitle(Text(category.name))
        .toolbar {
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            
            filteredProducts = []
            realmManager.products = []
            realmManager.getitems(categoryId: category.id)
            print("selected index", selectedIndex)
        }
    }
}

//struct CategoriesView_Previews: PreviewProvider {
//
//
//    static var realmManager: RealmManager {
//
//        let realmManager = RealmManager()
//
//        realmManager.addTask(title: "Orange Juice", image: "1", price: 4.99, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//        realmManager.addTask(title: "Chocolate Ice Cream", image: "2", price: 2.49, category: "ice cream", expirationDate: "10 days", country: "Russia", storageConditions: "freezer")
//        realmManager.addTask(title: "Kiwi Juice", image: "3", price: 4.39,  category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//
//        return realmManager
//    }
//    static var previews: some View {
//
//        CategoriesView(productType: ProductType(name: "ih", image: "hi", category: ["All", "Choco"]))
//            .environmentObject(realmManager)
//    }
//}

struct CategoryView: View {
    let isActive: Bool
    let text: String
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            Text(text)
                .font(Font.custom("SFProText-Regular", fixedSize: 18))
                .frame(alignment: .leading)
                .foregroundColor(isActive ? blackBasic : darkGrayBasic)
                .padding(8)
                .padding(.leading, 4)
                .padding(.trailing, 4)
                .background(isActive ? greyAccent : backgroundColor1)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isActive ? .white : greyAccent, lineWidth: isActive ? 0 : 2)
                )
            if (isActive) {
            }
        }
        .padding(isActive ? 0 : 2)
        .clipped()
        .cornerRadius(isActive ? 20 : 0)
    }
}

func getItemWidth() -> CGFloat {
    
    //    let screenSize: CGRect = UIScreen.main.bounds
    //    var width = 185.0
    //
    //    if screenSize.width < 330 {
    //        width = 130
    //    } else if screenSize.width > 420 {
    //        width = 180
    //    }
    
    return UIScreen.main.bounds.size.width / 2 - 24
    //    return width
}
