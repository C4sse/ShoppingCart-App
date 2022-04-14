//
//  HomeView.swift
//  ShoppingCart
//
//  Created by George Nhari on 8/4/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 12)]
    var productTypeList = [
        ProductType(name: "Sweets, Cookies", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Meat, poultry", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Milk, eggs", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Bread, pastries", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Snacks snacks", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Pet products", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Household goods", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Household chemicals", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Ready-made food", image: "cookies", category: ["All", "chocolate"])
    ]
    
    @EnvironmentObject var cartManager: CartManager
    
    var productList: [Product]
    
    var searchResults: [ProductType] {
            if searchText.isEmpty {
                return productTypeList
            } else {
                return productTypeList.filter { $0.name.contains(searchText) }
            }
        }
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: columns, spacing: 12) {
                    
                    ForEach(searchResults, id: \.id) { productType in
                    
                        NavigationLink(destination: CategoriesView(productList: productList, productType: productType)
                                .environmentObject(cartManager)) {
                                    CatalogueCell(width: getItemWidth(), productType: productType)
                                }
                        
                    }
                }
                .padding()
            }
            .background(backgroundColor1)
            .navigationTitle(Text("Catalogue"))
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic)) {
            }
            .toolbar {
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(productList: [Product(name: "Orange Juice", image: "1", price: 4.99, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate"),
                               Product(name: "Chocolate Ice Cream", image: "2", price: 2.49, category: "ice cream", expirationDate: "10 days", country: "Russia", storageConditions: "freezer"),
                               Product(name: "Kiwi Juice", image: "3", price: 4.39,  category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")])
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
