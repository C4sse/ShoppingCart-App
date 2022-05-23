//
//  SettingsView.swift
//  FlickMeter
//
//  Created by Stacey Smith on 4/7/22.
//

import SwiftUI

struct Settings: View {
    
    @State var isOn: Bool = true
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                Section {
                    
                    NavigationLink {
                     
                        ProfileSettings()
                    } label: {
                        
                        HStack {
                            
                            Text("Profile")
                                .foregroundColor(.primary)
                            
                        }
                    }
                    
                    NavigationLink {
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Shipping Address")
                                .foregroundColor(.primary)
                            
                        }
                    }
                }
                
                Section {
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Ship to")
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("🇹🇿")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Currency")
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("USD")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Language")
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("English")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section {
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Notification Settings")
                                .foregroundColor(.primary)
                            
                        }
                    }
                }
                
                Section() {
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("App Suggestion")
                                .foregroundColor(.primary)
                            Spacer()
                            
                        }
                    }
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Report Data Issue")
                                .foregroundColor(.primary)
                            Spacer()
                            
                        }
                    }
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        
                        Text("Email Support")
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    
                    NavigationLink {
                        
                        AddItemToShop()
                    } label: {
                        
                        
                        Text("Add item to shop")
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }
                
                Section() {
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Rate ShoppingCart")
                                .foregroundColor(.primary)
                            Spacer()
                            
                        }
                    }
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Terms of Use")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    NavigationLink {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Privacy Policy")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button {
                        
                        
                    } label: {
                        
                        HStack {
                            
                            Text("Version")
                                .foregroundColor(.primary)
                            Spacer()
                            Text("1.0.1")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section {
                    Button {
                        
                        Api.Auth.signOut(completion: {
                            isLoggedIn = Api.User.CURRENT_USER != nil
                        })
                    } label: {
                        
                        HStack {
                            
                            Spacer()
                            Text("Sign Out")
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .listRowBackground(redAccent)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    
    @State static var isLoggedIn: Bool = true
    
    static var previews: some View {
        Settings(isLoggedIn: $isLoggedIn)
            .preferredColorScheme(.light)
    }
}
