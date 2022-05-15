//
//  HomeView.swift
//  ShoppingCart
//
//  Created by George Nhari on 8/4/2022.
//

import SwiftUI

struct HomeView: View { // change
    
    @Binding var realmManager: RealmManager
    @State private var searchText = ""
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 12)]
    var productTypeList = [
        ProductType(name: "Sweets, Cookies", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Meat, poultry", image: "meat", category: ["All", "chocolate"]),
        ProductType(name: "Milk, eggs", image: "milk", category: ["All", "chocolate"]),
        ProductType(name: "Bread, pastries", image: "bread", category: ["All", "chocolate"]),
        ProductType(name: "Snacks snacks", image: "cookies", category: ["All", "chocolate"]),
        ProductType(name: "Pet products", image: "pet", category: ["All", "chocolate"]),
        ProductType(name: "Household goods", image: "chems", category: ["All", "chocolate"]),
        ProductType(name: "Household chemicals", image: "chems", category: ["All", "chocolate"]),
        ProductType(name: "Ready-made food", image: "precooked", category: ["All", "chocolate"])
    ]
    
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
                        
                        NavigationLink(destination: CategoriesView(productType: productType)
                            .environmentObject(realmManager)) {
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            //#warning("Some message")
//            realmManager.deleteAll()
//            realmManager.addTask(title: "Orange Juice", image: "1", price: 4.99, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Chocolate Ice Cream", image: "2", price: 2.49, category: "ice cream", expirationDate: "10 days", country: "Russia", storageConditions: "freezer")
//            realmManager.addTask(title: "Kiwi Juice", image: "3", price: 4.39,  category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Watermellon Juice", image: "4", price: 2.39,  category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Banana And oats", image: "5", price: 4.79, category: "meal", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Banana Breakfast", image: "6", price: 2.39, category: "meal", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Strawberry Ice cream", image: "7", price: 3.33, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "freezer")
//            realmManager.addTask(title: "Orange", image: "8", price: 1.39, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Mint Ice cream", image: "11", price: 2.21, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "freezer")
//            realmManager.addTask(title: "Banana", image: "12", price: 0.39, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Mixed Flavor", image: "13", price: 2.75, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Blue-berry Flavor", image: "12", price: 2.00, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Strawberry", image: "17", price: 2.99, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Vanilla", image: "19", price: 1.00, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "freezer")
//            realmManager.addTask(title: "Caramel", image: "23", price: 1.00, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Blue-berry Flavor", image: "12", price: 1.00, category: "dessert", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Apple Juice", image: "29", price: 3.19, category: "juice", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Tomatoes", image: "20", price: 2.00, category: "vegetables", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Carrot", image: "15", price: 1.10, category: "vegetables", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
//            realmManager.addTask(title: "Paper", image: "25", price: 2.00, category: "vegetables", expirationDate: "10 days", country: "Russia", storageConditions: "refrigerate")
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

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
