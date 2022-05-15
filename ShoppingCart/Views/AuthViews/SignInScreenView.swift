//
//  SignInScreenView.swift
//  login
//
//  Created by Abu Anwar MD Abdullah on 23/4/21.
//

import SwiftUI
import Firebase
import AuthenticationServices
import ProgressHUD
import SafariServices
import RealmSwift

struct SignInScreenView: View {
    
    @Binding var isSignedIn : Bool
    @State private var showSafari: Bool = false
    @StateObject var loginData = LoginViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                backgroundColor2
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    
                    VStack {
                        Text("Sign In")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 30)
                        
                        SignInWithAppleButton { (request) in
                            
                            loginData.nonce = Api.Auth.randomNonceString()
                            request.requestedScopes = [.email, .fullName]
                            request.nonce = Api.Auth.sha256(loginData.nonce)
                            
                        } onCompletion: { (result) in
                            
                            switch result {
                            case .success(let user):
                                // do
                                print("success")
                                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                    ProgressHUD.showError("Error with firebase")
                                    return
                                }
                                
                                loginData.authenticate(credential: credential, onSuccess: {
                                    
                                    withAnimation(.easeOut) {
                                        self.isSignedIn = true
                                    }
                                })
                            case .failure(let error):
                                ProgressHUD.showFailed(error.localizedDescription)
                                return
                            }
                        }
                        .signInWithAppleButtonStyle(.white)
                        .frame(height: 55)
                        .clipShape(Capsule())
                        .padding()
                        
                        SocalLoginButton(image: Image(uiImage: #imageLiteral(resourceName: "google")), text: Text("Sign in with Google"))
                            .onTapGesture {
                                
                                Api.Auth.googleSignIn(viewController: getRootViewController(), onSuccess: {
                                    withAnimation(.easeOut) {
                                        self.isSignedIn = true
                                    }
                                })
                            }
                        
                        Text("or")
                            .foregroundColor(Color.black.opacity(0.4))
                        
                        NavigationLink {
//                            SignUpView(isSignedIn: $isSignedIn)
                            SignInView(isSignedIn: $isSignedIn)
                                .navigationBarHidden(true)
                        } label: {
                            
                            SocalLoginButton(image: Image(uiImage: #imageLiteral(resourceName: "google")), text: Text("Continue with Email"))
                            
                        }
                    }
                    
                    Spacer()
                    Divider()
                    Text("By Continuing you are agreeing with our")
                        .font(.custom("SFProText-Light", size: 14))
                        .padding(.top, 16)
                    Text("Terms & Conditions.")
                        .font(.custom("SFProText-Regular", size: 14))
                        .foregroundColor(blueBasic)
                        .onTapGesture {
                                showSafari.toggle()
                        }
                        .fullScreenCover(isPresented: $showSafari, content: {
                            if let url = URL(string: "https://qwicktake.com/terms") {
                                SFSafariViewWrapper(url: url)
                            }
                        })
                    Spacer()
                    
                }
                .padding()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
    }
        
}

struct SignInScreenView_Previews: PreviewProvider {
    
    @State static var rootIsActivee : Bool = false
    
    static var previews: some View {
        SignInScreenView(isSignedIn: $rootIsActivee)
            .preferredColorScheme(.light)
    }
}


struct SocalLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack() {
                
                Spacer()
                
                image
                    .resizable()
                    .padding(.leading, 8)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 18)
                
                
                text
                    .font(.custom("SFProText-Semibold", size: 19))
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 55)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
        .clipShape(Capsule())
        .padding()
    }
}

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(50)
    }
}

extension View {
    
    func getRootViewController() -> UIViewController {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}
