//
//  LoginView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State var inProgress = false
    @State private var showError = false
    private let errorTitle = "Failed"
    @State private var errorMessage = "Error in Login, Please try again..!"
    
    var body: some View {
        NavigationView {
            ZStack {
                getGradientView()
                LoadingView(isShowing: $inProgress) { //Loading view
                ScrollView {
                    VStack {
                        getHeaderView()
                        getEmailPasswordView()
                        Spacer()
                        addSignUpButton()
                    }.frame(height: UIScreen.main.bounds.height * 0.9)
                }
            }
            }.alert(Text(errorTitle), isPresented: $showError) {
                Button("Ok", role: .cancel, action: {
                    showError = false
                })
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func getGradientView() -> some View {
        LinearGradient(colors: [Color.black, Color.gray],
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
    }
    
    func getHeaderView() -> some View {
        VStack(alignment: .center) {
            Image(systemName: "scissors.circle.fill")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 150, height: 150)
                .padding()
            Text("Hair Dresser")
                .foregroundColor(.white)
                .font(.title)
        }.padding()
    }
    
    func getEmailPasswordView() -> some View {
        VStack(spacing: 20) {
            
            //Email
            CustomTextField(text: $email,
                            placeHolderText: "Email",
                            imageName: "envelope")
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            
            //Password
            CustomSecuredTextField(text: $password,
                                   placeHolderText: "Password")
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            
            //Forgot password
            getForgotPasswordButton()
            //Sign in button
            getSignInButton()
                .padding(.horizontal, 32)
        }
    }
    
    func getForgotPasswordButton() -> some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Text("Forgot Password?")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top)
                    .padding(.trailing, 28)
            }
        }
    }
    
    func getSignInButton() -> some View {
        HStack {
            Button {
                inProgress = true
                authViewModel.login(email: email, password: password) { success, error in
                    inProgress = false
                    if let error {
                        print(error)
                        errorMessage = error
                        showError = true
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("LightPink"))
                    .clipShape(Capsule())
            }
        }
    }
    
    func addSignUpButton() -> some View {
        HStack {
            NavigationLink(destination: RegistrationView(), label: {
                HStack {
                    Text("Don't have an account?")
                        .font(.system(size: 14))
                    Text("Sign Up")
                        .font(.system(size: 14, weight: .semibold))
                }.foregroundColor(.white)
            }).padding(.bottom, 32)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
