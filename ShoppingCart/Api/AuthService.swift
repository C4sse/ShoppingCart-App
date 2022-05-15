//
//  AuthService.swift
//  ShoppingCart
//
//  Created by George Nhari on 16/4/2022.
//

import FirebaseAuth
import FirebaseAnalytics
import ProgressHUD
import GoogleSignIn
import Firebase
import SwiftUI
import CryptoKit

class AuthService {
    
    /** This function take user input during login attempt.
    - Parameter email: a string value with no whitespaces
    - Parameter password: a string value
    - Parameter onSuccess: A closure that is called dut to successfull API call
    - Parameter onError: closure to display error on event of failed API call
    - Parameter errorMessage: A string value passed to the closure onError()
    - Returns: escaping method
       */
    static func signin(email: String,  password: String,
                      onSuccess: @escaping() -> Void,
                      onError: @escaping() -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                onError()
                return
            }
            
            Analytics.logEvent(AnalyticsEventLogin, parameters: [AnalyticsParameterMethod: "email"])
            
            if let uid = Api.User.CURRENT_USER?.uid {
                
                Analytics.setUserID(uid)
            }
            
            onSuccess()
        })
    }
    
    /// This function takes user input for API call
    ///  - Parameter username: string value
    ///  - Parameter email: a astring value
    ///  - Parameter password: a string value
    ///  - Parameter imageData: byte buffer
    ///  - Parameter errorMessage: the string parameter for closure
    ///  - Parameter onError: the closure to return error message from API call
    static func signUp(username: String, email: String, password: String,
                        onSuccess: @escaping() -> Void) {
            
        
        ProgressHUD.show()
        // Create user with arguments provided, receive Authentication result from closure
        Auth.auth().createUser(withEmail: email, password: password) { (authData: AuthDataResult?, error: Error?) in
            
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
//            Analytics.logEvent(AnalyticsEventSignUp, parameters: [AnalyticsParameterSignUpMethod: "email"])
            
            if let user = authData?.user {
                
                let changeRequest = user.createProfileChangeRequest()
                
                changeRequest.displayName = username
                changeRequest.commitChanges { error in
                    
                    if error != nil {
                        // An error happened.
                        ProgressHUD.showError(error?.localizedDescription)
                        return
                    }
                    
                    // Analytics.setUserProperty(username, forName: "username")
                    
                    self.setUserInformation(profileImageUrl: nil, username: username, email: email,  uid: user.uid, onSuccess: {
                        
                        onSuccess()
                        ProgressHUD.dismiss()
                    })
                    
                }
            }
        }
    }
    
    static func googleSignIn(viewController: UIViewController, onSuccess: @escaping() -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // create signin config
        let config = GIDConfiguration(clientID: clientID)
        
        ProgressHUD.show()
        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewController) { user, error in
            
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                ProgressHUD.dismiss()
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authData, error in
                
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    return
                }
                
                if let user = authData?.user {
                    
                    // Analytics.setUserProperty(username, forName: "username")
                    self.setUserInformation(profileImageUrl: nil, username: user.displayName! , email: user.email!,  uid: user.uid, onSuccess: {
                        
                        ProgressHUD.dismiss()
                        onSuccess()
                    })
                }
            }
        }
    }
    
    /// update user information
    /// - Parameters:
    ///   - profileImageUrl: profile image
    ///   - username: user's name
    ///   - email: their email
    ///   - uid: the user's id
    ///   - onSuccess: was a success
    static func setUserInformation(profileImageUrl: String?, username: String, email: String, uid: String,
                                   onSuccess: @escaping() -> Void) {
        
        let databaseRef = Config.REF_USERS
        let newUserReference = databaseRef.child(uid)
        
        newUserReference.setValue(["username": username,
                                   "name": username,
                                   "usernameLowercase": username.lowercased(),
                                   "email": email,
                                   "profileImageUrl": profileImageUrl]) { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            
            if let user = Api.User.CURRENT_USER {
                
                let changeRequest = user.createProfileChangeRequest()
                
                changeRequest.displayName = username
                if let profileImageUrl = profileImageUrl { changeRequest.photoURL = NSURL(string: profileImageUrl) as URL? }
                
                changeRequest.commitChanges { error in
                    
                    if error != nil {
                        ProgressHUD.showError(error?.localizedDescription)
                        return
                    }
                    
                    Analytics.logEvent("change_request", parameters: nil)
                    
                    onSuccess()
                }
            }
        }
    }
    
    static func signOut() {
        
        do {
            
            GIDSignIn.sharedInstance.signOut()
            try Auth.auth().signOut()
            
        } catch let logoutError {
            ProgressHUD.showError(logoutError.localizedDescription)
            return
        }
    }
    
    @available(iOS 13, *)
    static func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

        
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    static func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }

        
}
