//
//  SignInView.swift
//  ShoppingCart
//
//  Created by George Nhari on 19/4/2022.
//

import SwiftUI

struct SignInView: View {
    
    @State var user = User()
    @Binding var isSignedIn : Bool
    @State private var isShowingSignUpView = false
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .center) {
                
                NavigationLink(destination: SignUpView(isSignedIn: $isSignedIn, isShowingSignUpView: $isShowingSignUpView), isActive: $isShowingSignUpView) { EmptyView() }
                
                Text("Sign in")
                    .font(.custom("SFProDisplay-Bold", size: 30))
                    .foregroundColor(blackBasic)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20.0)
                
                VStack(spacing: 25.0) {
                    
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
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                    .background(Capsule().fill(Color.white))
                    .overlay(user.isPasswordValid || user.password.isEmpty ? RoundedRectangle(cornerRadius: 30)
                        .stroke(lightGrayBasic, lineWidth: 1) : RoundedRectangle(cornerRadius: 30)
                        .stroke(redAccent, lineWidth: 1))
                    
                    // BUTTON
                    if self.isUserInformationValid() {
                        
                        Button(action: {
                            
                            Api.Auth.signin(email: user.email, password: user.password) {
                                withAnimation(.easeOut) {
                                    self.isSignedIn = true
                                }
                            } onError: {
                                
                            }
                        }, label: {
                            Text("SIGN IN")
                            .font(.headline)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        })
                        .buttonModifier(isDisabled: false, start: blueBasic, end: blueBasic)
                    } else {
                        Button(action: {
                            print("should not print")
                        }, label: {
                            Text("SIGN IN")
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
                
                
                HStack {
                    Text("Don't have an account?")
                        .italic()
                        .foregroundColor(Color.gray)
                    
                    Text("Sign up")
                        .italic()
                        .foregroundColor(Color.blue)
                }
                .font(.custom("Avenir", size: 15))
                .padding(.top, 30)
                .onTapGesture {
                    
                    isShowingSignUpView.toggle()
                }
            }
            .frame(height: UIScreen.main.bounds.size.height)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
    
    private func isUserInformationValid() -> Bool {
        
        if !user.isEmailValid {
            return false
        }
        
        if !user.isPasswordValid {
            return false
        }
        
        return true
    }
}

struct SignInView_Previews: PreviewProvider {
    
    @State static var isSignedIn : Bool = false
    
    static var previews: some View {
        SignInView(isSignedIn: $isSignedIn)
    }
}
