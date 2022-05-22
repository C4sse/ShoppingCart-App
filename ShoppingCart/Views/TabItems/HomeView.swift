//
//  HomeView.swift
//  ShoppingCart
//
//  Created by George Nhari on 8/4/2022.
//

import SwiftUI

struct HomeView: View { // change
    
    @EnvironmentObject var categoriesManager: CategoriesManager
    @State private var searchText = ""
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 12)]
    
//    var searchResults: [Realm] {
//        if searchText.isEmpty {
//            return productTypeList
//        } else {
//            return productTypeList.filter { $0.name.contains(searchText) }
//        }
//    }
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: columns, spacing: 12) {
                    
                    ForEach(categoriesManager.categories, id: \.id) { category in
                        
                        NavigationLink(destination: CategoriesView(category: category)) {
                            CatalogueCell(width: getItemWidth(), name: category.name)
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
            RealmManager().deleteAll()
            categoriesManager.getCategories(categoriesManager: categoriesManager)
            let dict: [String: Any] = [
                "name": "Choco",
                "image": "https://loremflickr.com/cache/resized/65535_51997341473_55b86a2b17_n_320_240_nofilter.jpg",
                "price": 2.0,
                "availableQuantity": 3,
                "type": "chocolate"
            ]
            ItemsApi.addProductToStore(dict: dict, forCategoryId: "123")
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
