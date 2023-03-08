//
//  RegistrationView.swift
//  InstagramSwiftUI
//
//  Created by Girolkar, Ajay W on 03/03/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var password = ""
    @State private var selectedImage: UIImage?
    @State private var postImage: Image?
    @State var imagePickerPresented = false
    @State private var selectedUserRole = "User"
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @State var userRole: UserRole = .user
    
    init() {
        UISegmentedControl.appearance().backgroundColor = .lightGray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        ZStack {
            getGradientView()
            ScrollView {
                VStack {
                    getUploadPhotoButton()
                    getUserDetailView()
                    Spacer()
                    addSignInButton()
                }.frame(height: UIScreen.main.bounds.height * 0.9)
            }
        }
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
            if let postImage = postImage {
                postImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            } else {
                Button {
                    imagePickerPresented.toggle()
                } label: {
                    ImageHelper.getPlusCircleImageView(foreGroundColor: .white)
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                }.sheet(isPresented: $imagePickerPresented, onDismiss: loadImage) {
                    ImagePicker(image: $selectedImage)
                }
            }
        }.padding()
        
    }
    
    func getUserDetailView() -> some View {
        VStack(spacing: 20) {
            //Email
            CustomTextField(text: $email,
                            placeHolderText: "Email",
                            imageName: "envelope")
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            
            //Username
            CustomTextField(text: $username,
                            placeHolderText: "Username",
                            imageName: "person")
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            
            //Full name
            CustomTextField(text: $fullname,
                            placeHolderText: "Full name",
                            imageName: "person")
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            
            //Password
            CustomSecuredTextField(text: $password,
                                   placeHolderText: "Password")
            .cornerRadius(10)
            .foregroundColor(.white)
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
                let selectedImage = selectedImage ?? UIImage(systemName: "profile")
                if let selectedImage {
                    authViewModel.register(email: email, password: password, image: selectedImage, fullname: fullname, username: username, userRole: selectedUserRole)
                }
                
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("LightPink"))
                    .clipShape(Capsule())
            }
        }
    }
    
    func addUserRoleView() -> some View {
        VStack {
            CustomSegmentView(selectedId: $selectedUserRole, values: ["User", "Owner"])
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


extension RegistrationView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
