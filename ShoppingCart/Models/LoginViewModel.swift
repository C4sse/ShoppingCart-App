//
//  LoginViewModel.swift
//  ShoppingCart
//
//  Created by George Nhari on 19/4/2022.
//

import Foundation
import AuthenticationServices
import Firebase
import ProgressHUD
import SwiftRandom

class LoginViewModel: ObservableObject {
    
    @Published var nonce = ""
    
    func authenticate(credential: ASAuthorizationAppleIDCredential, onSuccess: @escaping() -> Void) {
        
        print(nonce)
        
        // getting token
        guard let token = credential.identityToken else {
            ProgressHUD.showError("Firebase error")
            return
        }
        
        // token string
        guard let tokenString = String(data: token, encoding: .utf8) else {
            ProgressHUD.showError("Token error")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: firebaseCredential) { (user, error) in
            
            if error != nil {
                ProgressHUD.showFailed(error?.localizedDescription)
                return
            }
            
            // User Successfully logged in
            guard let user = user else { return }
            
            Api.Auth.setUserInformation(profileImageUrl: "", username: user.user.displayName ?? Randoms.randomFakeName(), email: user.user.email ?? "", uid: user.user.uid) {
                onSuccess()
                ProgressHUD.showSucceed()
            }
        }
    }
}
