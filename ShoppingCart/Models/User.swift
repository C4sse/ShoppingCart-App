//
//  User.swift
//  ShoppingCart
//
//  Created by George Nhari on 17/4/2022.
//

import Foundation

struct User {
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
        
    // EMAIL VALIDATION
    var isEmailValid: Bool {
        if email.count < 5 {
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    // PASSWORD VALIDATION
    var isPasswordValid: Bool {
        if password.count < 6 {
            return false
        }
        return true
    }
    
    // CONFIRM PASSWORD VALIDATION
    var isConfirmPasswordValid: Bool {
        if password != confirmPassword {
            return false
        }
        return true
    }
}
