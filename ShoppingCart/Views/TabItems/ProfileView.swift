//
//  ProfileView.swift
//  ShoppingCart
//
//  Created by George Nhari on 10/4/2022.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var showingSheet = false
    @Binding var isLoggedIn: Bool
    
    private var username: String {
        
        get {
            guard let name = Api.User.CURRENT_USER?.displayName else {
                return ""
            }
            
            return name
        }
    }
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .top) {
                            Image("Profile")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .cornerRadius(50)
                                .padding(.top, 8)
                            
                            VStack(alignment: .leading) {
                                Text(username)
                                    .font(Font.custom("SFProDisplay-Bold", fixedSize: 25))
                                    .padding(.top, 15)
                                    .padding(.bottom, 1)
                                
                                Text("+7(085)735-65-94")
                                    .font(Font.custom("SFProText-Normal", fixedSize: 16))
                                    .padding(.top, 0)
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("Total spent to date:")
                                .font(Font.custom("SFProText-Bold", fixedSize: 18))
                            .padding(.top, 8)
                            
                            Text("$\(80.0, specifier: "%.2f")")
                                .font(Font.custom("SFProText-Bold", size: 20))
                                .foregroundColor(greenBasic)
                            .padding(.top, 8)
                        }
                        
                    }
                }
                
                Section {
                    
                    NavigationLink {
                        
                    } label: {
                        
                        Text("Orders")
                            .font(Font.custom("SFProText-Bold", fixedSize: 19))
                        Spacer()
                        Text("View all")
                            .font(Font.custom("SFProText-Normal", fixedSize: 13))
                        
                    }
                    
                    HStack {
                        VStack {
                            Image(systemName: "creditcard.fill")
                                .resizable()
                                .frame(width: 24, height: 20)
                                .padding(.top, 8)
                            Text("Unpaid")
                                .font(Font.custom("SFProText-Light", fixedSize: 12))
                                .padding(.top, 1)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "shippingbox.fill")
                                .resizable()
                                .frame(width: 24, height: 20)
                                .padding(.top, 8)
                            Text("To be Shipped")
                                .font(Font.custom("SFProText-Light", fixedSize: 12))
                                .padding(.top, 1)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "airplane.departure")
                                .resizable()
                                .frame(width: 24, height: 20)
                                .padding(.top, 8)
                            Text("Shipped")
                                .font(Font.custom("SFProText-Light", fixedSize: 12))
                                .padding(.top, 1)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "checkmark.bubble.fill")
                                .resizable()
                                .frame(width: 24, height: 20)
                                .padding(.top, 8)
                            Text("To be reviewed")
                                .font(Font.custom("SFProText-Light", fixedSize: 12))
                                .padding(.top, 1)
                        }
                    }
                        
                }
                
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    SettingsButton() // goes to settingsView
                        .foregroundColor(.black)
                        .onTapGesture {
                            showingSheet.toggle()
                        }
                }
            }
            .navigationTitle(Text("Profile"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showingSheet) {
            Settings(isLoggedIn: $isLoggedIn)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    @State static var isLoggedIn = true
    
    static var previews: some View {
        ProfileView(isLoggedIn: $isLoggedIn)
    }
}
