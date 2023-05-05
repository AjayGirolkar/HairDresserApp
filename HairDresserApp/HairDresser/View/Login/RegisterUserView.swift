//
//  RegisterUserView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var password = ""
    @State private var contactNumber = ""
    @State private var postImageArray = [UIImage]()
    @State var imagePickerPresented = false
    @State private var selectedUserRole = "Customer"
    @State var inProgress = false
    @State var isSuccess = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showUploadProfileError = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @State var userRole: UserRole = .customer
    
    init() {
        UISegmentedControl.appearance().backgroundColor = .lightGray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        ZStack {
            getGradientView()
            LoadingView(isShowing: $inProgress) { //Loading view
                ScrollView {
                    VStack {
                        getUploadPhotoButton()
                        getUserDetailView()
                        Spacer()
                        addSignInButton()
                    }.frame(height: UIScreen.main.bounds.height * 0.9)
                }
            }.toolbarBackground(Constants.backgroundColor, for: .navigationBar)
        }
        .background(Constants.screenBackgroundColor)
        .navigationBarHidden(true)
    }
    
    func getGradientView() -> some View {
        LinearGradient(colors: [Color.black, Color.gray],
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
    }
    
    func getUploadPhotoButton() -> some View {
        VStack {
            VStack {
                Button {
                    postImageArray.removeAll()
                    imagePickerPresented.toggle()
                } label: {
                    
                    if let firstImage = postImageArray.first {
                        let postImage = Image(uiImage: firstImage)
                        postImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        
                        ImageHelper.getPlusCircleImageView(foreGroundColor: .white)
                            .foregroundColor(.white)
                            .padding(.bottom, 30)
                    }
                    
                }.sheet(isPresented: $imagePickerPresented) {
                    ImagePickerView(images: $postImageArray,
                                    showPicker: $imagePickerPresented,
                                    selectionLimit: 1)
                }
                if showUploadProfileError {
                    Text("Please select profile image")
                        .foregroundColor(.red)
                }
            }
        }.padding()
        
    }
    
    func getUserDetailView() -> some View {
        VStack(spacing: 20) {
            //Email
            CustomTextField(text: $email,
                            placeHolderText: "Email",
                            imageName: "envelope",
                            backgroundColor: Color(.init(white: 1, alpha: 0.15)),
                            textColor: .white,
                            placeHolderColor: Color.init(.white.withAlphaComponent(0.8)))
            .cornerRadius(10)
            .padding(.horizontal, 32)
            
            //Username
            CustomTextField(text: $username,
                            placeHolderText: "Username",
                            imageName: "person",
                            backgroundColor: Color(.init(white: 1, alpha: 0.15)),
                            textColor: .white,
                            placeHolderColor: Color.init(.white.withAlphaComponent(0.8)))
            .cornerRadius(10)
            .padding(.horizontal, 32)
            
            //Full name
            CustomTextField(text: $fullname,
                            placeHolderText: "Full name",
                            imageName: "person",
                            backgroundColor: Color(.init(white: 1, alpha: 0.15)),
                            textColor: .white,
                            placeHolderColor: Color.init(.white.withAlphaComponent(0.8)))
            .cornerRadius(10)
            .padding(.horizontal, 32)
            
            //Password
            CustomSecuredTextField(text: $password,
                                   placeHolderText: "Password",
                                   backgroundColor: Color(.init(white: 1, alpha: 0.15)),
                                   textColor: .white,
                                   placeHolderColor: Color.init(.white.withAlphaComponent(0.8)))
            .cornerRadius(10)
            .padding(.horizontal, 32)
            
            //Contact Number
            CustomTextField(text: $contactNumber,
                            placeHolderText: "Contact Number",
                            imageName: "phone",
                            backgroundColor: Color(.init(white: 1, alpha: 0.15)),
                            textColor: .white,
                            placeHolderColor: Color.init(.white.withAlphaComponent(0.8)))
            .cornerRadius(10)
            .padding(.horizontal, 32)
            
            Spacer()
                .frame(height: 30)
            
            addUserRoleView()
                .padding(.horizontal, 32)
            
            //SignUp button
            getSignUpButton()
                .padding(.horizontal, 32)
        }
    }
    
    func getSignUpButton() -> some View {
        HStack {
            Button {
                let selectedImage: UIImage? = postImageArray.first ?? UIImage(systemName: "profile")
                if let selectedImage {
                    inProgress = true
                    isSuccess = false
                    authViewModel.register(email: email, password: password,
                                           image: selectedImage, fullname: fullname,
                                           contactNumber: contactNumber,
                                           username: username, userRole: selectedUserRole) { success, error in
                        if let error {
                            alertMessage = "Failed to create user: \(error)"
                        } else {
                            alertMessage = "Successfully created user"
                            isSuccess = true
                        }
                        inProgress = false
                        showingAlert = true
                    }
                } else {
                    showUploadProfileError = true
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("LightPink"))
                    .clipShape(Capsule())
            }.alert(alertMessage, isPresented: $showingAlert, actions: {
                if isSuccess {
                    Button("Ok") {
                        authViewModel.fetchUser()
                    }
                }
            })
        }
    }
    
    func addUserRoleView() -> some View {
        VStack {
            CustomSegmentView(selectedId: $selectedUserRole, values: ["Customer", "Owner"])
        }
    }
    
    func addSignInButton() -> some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 14))
                    Text("Sign In")
                        .font(.system(size: 14, weight: .semibold))
                }.foregroundColor(.white)
            }.padding(.bottom, 32)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
