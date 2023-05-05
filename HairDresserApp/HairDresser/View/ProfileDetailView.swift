//
//  ProfileDetailView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI

struct ProfileDetailView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var password = ""
    @State private var contactNumber = ""
    @State private var selectedImage: UIImage?
    @State private var postImageArray = [UIImage]()
    @State var imagePickerPresented = false
    @State var inProgress = false
    @State var isSuccess = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showUploadProfileError = false
    @State var inEditMode: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var viewModel: ProfileDetailViewModel
    
    var user: User
    
    init(user: User) {
        self.user = user
        viewModel = ProfileDetailViewModel(user: user)
        _email = State(initialValue: user.email)
        _fullname = State(initialValue: user.fullname)
        _username = State(initialValue: user.username)
        _contactNumber = State(initialValue: user.contactNumber ?? "")
    }
    
    var body: some View {
        ZStack {
            getGradientView()
            LoadingView(isShowing: $inProgress) { //Loading view
                ScrollView {
                    VStack {
                        VStack {
                            profileHeaderView
                            
                            getUserDetailView()
                        }.disabled(!inEditMode)
                        //SignUp button
                        getSignUpButton()
                            .padding(.horizontal, 32)
                    }//.frame(height: UIScreen.main.bounds.height * 0.9)
                }
            }
        }.background(Constants.screenBackgroundColor)
            .navigationTitle("Profile")
    }
    
    func getGradientView() -> some View {
        LinearGradient(colors: [Color.black, Color.black.opacity(0.7)],
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
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
            
            //Contact Number
            CustomTextField(text: $contactNumber,
                            placeHolderText: "Contact Number",
                            imageName: "phone")
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
        }
    }
    
    func getSignUpButton() -> some View {
        HStack {
            Button {
                inEditMode.toggle()
            } label: {
                Text(inEditMode  ?  "Update Profile" : "Edit Profile")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color("LightPink"))
                    .clipShape(Capsule())
            }.alert(alertMessage, isPresented: $showingAlert) {
                if isSuccess {
                    LoginView()
                }
            }
        }
    }
    
}
extension ProfileDetailView {
    
    var profileHeaderView: some View {
        HStack(alignment: .center) {
            VStack {
                Button {
                    postImageArray.removeAll()
                    imagePickerPresented = true
                } label: {
                    if let firstImage = postImageArray.first {
                        let postImage = Image(uiImage: firstImage)
                        postImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        getAsyncImage()
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
            
        }.frame(maxWidth: .infinity)
    }
    
    func getAsyncImage() -> some View {
        ZStack {
            AsyncImage(url: URL(string: viewModel.user.profileImageUrl ?? ""), scale: 2) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
            } placeholder: {
                Image(systemName: "profile")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
            }
        }
    }
}


struct ProfileDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileDetailView(user: Constants.placeHolderUser)
    }
}
