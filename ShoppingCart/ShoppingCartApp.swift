//
//  ShoppingCartApp.swift
//  ShoppingCart
//
//  Created by George Nhari on 27/2/2022. 
//

import SwiftUI
import Firebase
import RealmSwift
import GoogleSignIn

@main
struct ShoppingCartApp: SwiftUI.App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
          
      return GIDSignIn.sharedInstance.handle(url)
    }
}
