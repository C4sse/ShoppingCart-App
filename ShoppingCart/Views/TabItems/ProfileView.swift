//
//  ProfileView.swift
//  ShoppingCart
//
//  Created by George Nhari on 10/4/2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                Api.Auth.signOut()
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
