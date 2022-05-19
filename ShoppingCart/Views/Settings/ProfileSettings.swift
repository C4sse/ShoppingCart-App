//
//  ProfileSettings.swift
//  ShoppingCart
//
//  Created by George Nhari on 19/5/2022.
//

import SwiftUI

struct ProfileSettings: View {
    
    private var email: String {
        
        get {
            guard let email = Api.User.CURRENT_USER?.email else {
                return ""
            }
            
            return email
        }
    }
    
    private var username: String {
        
        get {
            guard let name = Api.User.CURRENT_USER?.displayName else {
                return ""
            }
            
            return name
        }
    }
    
    var body: some View {
        
        List {
            Section {
                
                Button {
                    
                } label: {
                    
                    HStack {
                        Text("Photo")
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        ZStack {
                            Button {
                                
                            } label: {
                                
                                Image("Profile")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            }
                            
                            Image(systemName: "camera.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            
            Section {
                
                Button {
                    
                } label: {
                    
                    HStack {
                        Text("Account Info")
                        
                        Spacer()
                        
                        Text(email)
                            .foregroundColor(darkGrayBasic)
                    }
                }
                
                Button {
                    
                } label: {
                    
                    HStack {
                        Text("Name")
                    
                    Spacer()
                    
                    Text(username)
                        .foregroundColor(darkGrayBasic)
                    }
                }
                
                Button {
                    
                } label: {
                    
                    HStack {
                        Text("Gender")
                        
                        Spacer()
                        
                        Text("Male")
                            .foregroundColor(darkGrayBasic)
                    }
                }
            }
            
            Section {
                
                Button {
                    
                } label: {
                    
                    Text("Delete account")
                }
            }
        }
    }
}

struct ProfileSettings_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettings()
    }
}
