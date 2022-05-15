//
//  SignUpView.swift
//  ShoppingCart
//
//  Created by George Nhari on 17/4/2022.
//

import SwiftUI

struct SignUpView: View {
    
    @State var user = User()
    @Binding var isSignedIn : Bool
    @Binding var isShowingSignUpView : Bool
    @ObservedObject var keyboardResonder = KeyboardResponder()
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .center) {
                
                Text("Sign up")
                    .font(.custom("SFProDisplay-Bold", size: 30))
                    .foregroundColor(blackBasic)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20.0)
                
                VStack(spacing: 25.0) {
                    
                    // USERNAME
                    HStack {
                        Image(systemName: "person")
                            .padding()
                            .foregroundColor(lightGrayBasic)
                        
                        CustomTextField(placeholder: Text("Username").foregroundColor(lightGrayBasic), text: $user.username)
                            
                    }
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .background(Capsule().fill(Color.white))
                    .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(lightGrayBasic, lineWidth: 1))
                    
                    // EMAIL
                    HStack {
                        Image(systemName: "envelope")
                            .padding()
                            .foregroundColor(lightGrayBasic)
                        
                        CustomTextField(placeholder: Text("Email").foregroundColor(lightGrayBasic), text: $user.email)

                            if !user.email.isEmpty {
                                if !user.isEmailValid {
                                    Text("Invalid email")
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 10)
                                }
                            }
                    }
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .background(Capsule().fill(Color.white))
                    .overlay(user.isEmailValid || user.email.isEmpty ? RoundedRectangle(cornerRadius: 30)
                        .stroke(lightGrayBasic, lineWidth: 1) : RoundedRectangle(cornerRadius: 30)
                        .stroke(redAccent, lineWidth: 1))

                    // PASSWORD
                    HStack {
                        Image(systemName: "lock")
                            .padding()
                            .foregroundColor(lightGrayBasic)
                        
                        CustomSecureTextField(placeholder: Text("Password").foregroundColor(lightGrayBasic), text: $user.password)
                        
                        if !user.password.isEmpty {
                            if !user.isPasswordValid {
                                Text("Min. 6 characters")
                                .foregroundColor(Color.red)
                                .padding(.trailing, 10)
                            }
                        }
                    }
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .background(Capsule().fill(Color.white))
                    .overlay(user.isPasswordValid || user.password.isEmpty ? RoundedRectangle(cornerRadius: 30)
                        .stroke(lightGrayBasic, lineWidth: 1) : RoundedRectangle(cornerRadius: 30)
                        .stroke(redAccent, lineWidth: 1))
                    
                                
                    // CONFIRM PASSWORD
                    HStack {
                        Image(systemName: "lock")
                            .padding()
                            .foregroundColor(lightGrayBasic)
                        
                        CustomSecureTextField(placeholder: Text("Confirm Password").foregroundColor(lightGrayBasic), text: $user.confirmPassword)
                            .disabled(!user.isPasswordValid || user.password.isEmpty)
                        
                            if !user.isConfirmPasswordValid {
                                Text("Does not match")
                                .foregroundColor(Color.red)
                                .padding(.trailing, 10)
                            }
                    }
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .background(Capsule().fill(Color.white))
                    .overlay(user.isConfirmPasswordValid || user.confirmPassword.isEmpty ? RoundedRectangle(cornerRadius: 30)
                        .stroke(lightGrayBasic, lineWidth: 1) : RoundedRectangle(cornerRadius: 30)
                        .stroke(redAccent, lineWidth: 1))
                    
                    // BUTTON
                    if self.isUserInformationValid() {
                        
                        Button(action: {
                            
                            Api.Auth.signUp(username: user.username, email: user.email, password: user.password) {
                                withAnimation(.easeOut) {
                                    self.isSignedIn = true
                                }
                            }
                        }, label: {
                            Text("SIGN UP")
                            .font(.headline)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        })
                        .buttonModifier(isDisabled: false, start: blueBasic, end: blueBasic)
                    } else {
                        Button(action: {
                            print("should not print")
                        }, label: {
                            Text("SIGN UP")
                            .font(.headline)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        })
                        .buttonModifier(isDisabled: true,  start: lightAccent, end: greyAccent)
                    }
                }
                .padding(.top, 15.0)
                .padding(.horizontal, 40)
                .font(.custom("Avenir", size: 16))
        //        .background(Color(red: 248 / 255, green: 248 / 255, blue: 248 / 255))
                
                
                HStack {
                    Text("Already have an account?")
                        .italic()
                        .foregroundColor(Color.gray)
                    
                    Text("Sign in")
                        .italic()
                        .foregroundColor(Color.blue)
                }
                .font(.custom("Avenir", size: 15))
                .padding(.top, 30)
                .onTapGesture {
                    self.isShowingSignUpView.toggle()
                }
                
            }
            .frame(height: UIScreen.main.bounds.size.height)
            .padding(.bottom, keyboardResonder.currentHeight * 0.75) // not the best solution
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
//        .frame(height: UIScreen.main.bounds.size.height - 500)
//        .offset(y: -keyboardResonder.currentHeight)
    }
    
    private func isUserInformationValid() -> Bool {
        
        if user.username.isEmpty {
            return false
        }
        
        if !user.isEmailValid {
            return false
        }
        
        if !user.isPasswordValid {
            return false
        }
        
        if !user.isConfirmPasswordValid {
            return false
        }
        return true
    }
}

struct SignUpView_Previews: PreviewProvider {
    
    @State static var isSignedIn : Bool = false
    @State static var isShowingSignUpView : Bool = true
    
    static var previews: some View {
        SignUpView(isSignedIn: $isSignedIn, isShowingSignUpView: $isShowingSignUpView)
    }
}

//struct FormView: View {
//
//
//
//    var body: some View {
//
//    }
//
//
//}
//
//struct FormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .preferredColorScheme(.light)
//    }
//}

// CUSTOM TEXTFIELD
struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
            .autocapitalization(.none)
        }
        
    }
}

// SECURE TEXT CUSTOM TEXTFIELD FOR PASSWORDS
struct CustomSecureTextField: View {
    var placeholder: Text
    @Binding var text: String
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
           SecureField("", text: $text, onCommit: commit)
            .autocapitalization(.none)
        }
    }
}

// TEXTFIELD COLOR
extension Button {
    func buttonModifier(isDisabled: Bool, start: Color, end: Color) -> some View {
        self
            .disabled(isDisabled)
            .padding(.all, 6.0)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [start, end]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(30)
            .padding(.top, 45.0)
    }
}
