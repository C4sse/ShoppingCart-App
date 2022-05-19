//
//  ContentView.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State var realmManager = RealmManager()
    @State var isLoggedIn: Bool = Api.User.CURRENT_USER != nil
    private var token: NotificationToken?
    @StateObject var categoriesManager = CategoriesManager()
    
    var body: some View {
        
        if !isLoggedIn {
            
            SignInScreenView(isSignedIn: $isLoggedIn)
            
        } else {
            
            TabView {
                
                HomeView()
                    .environmentObject(categoriesManager)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Catalogue")
                    }
                
                DiscountView(realmManager: $realmManager)
                    .tabItem {
                        Image(systemName: "percent")
                        Text("Discount")
                    }

                CartView(realmManager: $realmManager)
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Cart")
                    }
//                    .badge(count)

                ProfileView(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
            .preferredColorScheme(.light)
        }
    }
    
    func checkIfLoggedin() {
        
        if Api.User.CURRENT_USER == nil {
            isLoggedIn = false
        } else {
            isLoggedIn = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
