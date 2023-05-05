//
//  SalonRegistationView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 06/04/23.
//

import SwiftUI


struct SalonRegistationView: View {
    @State private var salonName = ""
    @State private var ownerName = ""
    @State private var contactNumber = ""
    @State private var address = ""
    
    @State private var postImageArray = [UIImage]()
    @State var imagePickerPresented = false
    @State var inProgress = false
    @State var isSuccess = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showUploadProfileError = false
    @State private var openTime = Date.now
    @State private var closeTime = Date.now
    @State private var waitTime = "10.0"
    @State private var showCategoryInputView = false
    @State private var serviceList: [String: [String]] = [:]
    @ObservedObject var checkInDetailViewModel: CheckInDetailViewModel
    @State var categoryText = "Add category"
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.presentationMode) var presentationMode
    var locationManager = LocationManager()
    @State var submitErrorString = ""
    private var id: String
    private var salonDetails: SalonDetails?
    @State var loadingImages: Bool = false
    var isUpdate: Bool = false
    
    init(salonDetails: SalonDetails? = nil,
         isUpdate: Bool = false) {
        self.id = salonDetails?.id ?? UUID().uuidString
        self.salonDetails = salonDetails
        self.isUpdate = isUpdate
        checkInDetailViewModel =  CheckInDetailViewModel(salonDetails: Constants.salonDetailsExample)
        if let salonDetails = salonDetails {
            loadingImages = true
            initializeSalonDetails(salonDetails: salonDetails)
        }
    }
    
    var body: some View {
        ZStack {
            //getGradientView()
            LoadingView(isShowing: $inProgress) { //Loading view
                ScrollView {
                    VStack {
                        headerView
                        getUserDetailView()
                    }
                }
            }
        }
        .background(Constants.screenBackgroundColor)
        .navigationTitle("Register Your Salon")
        .onAppear {
            locationManager.requestLocation()
            updatedImages()
            updateCategoryText()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    
    func getGradientView() -> some View {
        LinearGradient(colors: [Color.black, Color.gray],
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
    }
    
    func getUserDetailView() -> some View {
        VStack(spacing: 20) {
            //Email
            CustomTextField(text: $salonName,
                            placeHolderText: "Salon Name",
                            imageName: "pencil")
            .cornerRadius(10)
            .foregroundColor(.primary)
            .padding(.horizontal, 32)
            
            //Username
            CustomTextField(text: $ownerName,
                            placeHolderText: "Owner Name",
                            imageName: "person")
            .cornerRadius(10)
            .foregroundColor(.primary)
            .padding(.horizontal, 32)
            
            //Contact Number
            CustomTextField(text: $contactNumber,
                            placeHolderText: "Contact Number",
                            imageName: "phone")
            .cornerRadius(10)
            .foregroundColor(.primary)
            .padding(.horizontal, 32)
            
            //Address
            CustomTextField(text: $address,
                            placeHolderText: "Address",
                            imageName: "house")
            .cornerRadius(10)
            .foregroundColor(.primary)
            .padding(.horizontal, 32)
            
            pickUpTimes
            
            Spacer()
                .frame(height: 30)
            
            //SignUp button
            getRegisterButton()
                .padding(.horizontal, 32)
        }
    }
    
    func getRegisterButton() -> some View {
        HStack {
            CustomButtonView(id: "", title: isUpdate ? "Update" : "Register") { _ in
                //  let selectedImage = selectedImage ?? UIImage(systemName: "profile")
                if postImageArray.count > 0,
                   let user = AuthenticationViewModel.shared.currentUser {
                    //get location
                    
                    let location = locationManager.location
                    let latitude = location?.coordinate.latitude ?? 0.0
                    let longitude = location?.coordinate.longitude ?? 0.0
                    let serviceList = checkInDetailViewModel.selectedServices.map { selectedServiceInput in
                        return [selectedServiceInput.categoryName: selectedServiceInput.serviceList]
                    }
                    
                    let salonDetails = SalonDetails(id: self.id,
                                                    uid: user.id ?? "",
                                                    salonName: salonName,
                                                    ownerName: ownerName,
                                                    email: user.email,
                                                    contactNumber: contactNumber,
                                                    address: address,
                                                    imageURLs: nil,
                                                    openTime: openTime.convertToTimeString(),
                                                    closeTime: closeTime.convertToTimeString(),
                                                    waitTime: Double(waitTime),
                                                    latitude: latitude,
                                                    longitude: longitude,
                                                    serviceList: nil)
                    inProgress = true
                    Task {
                        await FirebaseManager.register(isUpdate: isUpdate, salonDetails: salonDetails, images: postImageArray, selectedServices: serviceList) { success, error in
                            if let error {
                                alertTitle = "Oh no.. Try Again!"
                                alertMessage = "Failed to register salon: \(error)"
                            } else {
                                alertTitle = "Success"
                                alertMessage =  isUpdate ? "Successfully updated Salon Details." : "Successfully entered Salon Details."
                                isSuccess = true
                            }
                            inProgress = false
                            showingAlert = true
                        }
                    }
                } else {
                    showUploadProfileError = true
                }
            }
        }.frame(maxWidth: .infinity)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage),
                      dismissButton: .default(Text("Ok"), action: {
                    if isSuccess {
                        presentationMode.wrappedValue.dismiss()
                    }
                }))
            }
    }
}

extension SalonRegistationView {
    
    var headerView: some View {
        VStack {
            if loadingImages {
                ProgressView()
                    .frame(width: 150, height: 150)
            } else {
                if postImageArray.count > 0 {
                    imageSelectionView
                } else {
                    plusCircleImageView
                }
            }
        }.sheet(isPresented: $imagePickerPresented) {
            ImagePickerView(images: $postImageArray, showPicker: $imagePickerPresented, selectionLimit: 5)
        }
        .padding()
        
    }
    
    var imageSelectionView: some View {
        VStack {
            HStack {
                Spacer()
                clearAllButton
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<$postImageArray.count, id: \.self) { index in
                        let uiImage = postImageArray[index]
                        let image = Image(uiImage: uiImage)
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                    }
                }
            }
            uploadMoreImageButton
        }
    }
    
    var plusCircleImageView: some View {
        VStack {
            Button {
                imagePickerPresented.toggle()
            } label: {
                ImageHelper.getPlusCircleImageView(foreGroundColor: Color.primary)
                    .foregroundColor(.primary)
                    .padding(.bottom, 30)
            }
            if showUploadProfileError {
                Text("Please select profile image")
                    .foregroundColor(.red)
            }
        }
    }
    
    var uploadMoreImageButton: some View {
        Button {
            imagePickerPresented = true
        } label: {
            Text("Upload more Images")
        }.buttonStyle(.bordered)
            .padding(.vertical)
    }
    
    var clearAllButton: some View {
        Button {
            postImageArray.removeAll()
        } label: {
            Text("Clear All")
        }.buttonStyle(.plain)
            .tint(.primary)
            .padding(.vertical)
    }
    
    var pickUpTimes: some View {
        VStack {
            CustomTimePickerView(time: $openTime,
                                 text: "Open time",
                                 imageName: "stopwatch")
            .cornerRadius(10)
            .foregroundColor(.primary)
            .padding(.horizontal, 32)
            
            CustomTimePickerView(time: $closeTime,
                                 text: "Close time",
                                 imageName: "stopwatch")
            .cornerRadius(10)
            .foregroundColor(.primary)
            .padding(.horizontal, 32)
            
            waitTimeView
            categoryInputButton
        }
    }
    
    var waitTimeView: some View {
        ZStack(alignment: .leading) {
            HStack {
                Image(systemName: "stopwatch")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primary)
                
                Text("Wait time")
                    .padding(.horizontal, 10)
                Spacer()
                TextField("", text: $waitTime)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text(": min")
            }
        }.padding()
            .background(Color.primary.opacity(0.15))
            .cornerRadius(10)
            .foregroundColor(.primary)
            .padding(.horizontal, 32)
    }
    
    var categoryInputButton: some View {
        HStack {
            Button {
                showCategoryInputView.toggle()
            } label: {
                Text(categoryText)
            }.sheet(isPresented: $showCategoryInputView, onDismiss: {
                updateCategoryText()
            }) {
                CategoryInputView(checkInDetailViewModel: checkInDetailViewModel)
            }
        }.padding(.top)
    }
    
    func updateCategoryText() {
        let count = checkInDetailViewModel.selectedServices.count
        if count > 0 {
            categoryText = "\(count) categories selected"
        } else {
            categoryText = "Add category"
        }
    }
}

extension SalonRegistationView {
    
    func updatedImages() {
        if let salonDetails = salonDetails,
           let imagesUrls = salonDetails.imageURLs {
            loadingImages = true
            Task {
                if let images = try? await AsyncCaller.getImageFromURL(imageUrls: imagesUrls) {
                    postImageArray =  images
                    loadingImages = false
                }
            }
        }
    }
    
    mutating func initializeSalonDetails(salonDetails: SalonDetails) {
        _salonName = State(initialValue: salonDetails.salonName)
        _ownerName = State(initialValue: salonDetails.ownerName)
        _contactNumber = State(initialValue: salonDetails.contactNumber)
        _address = State(initialValue: salonDetails.address)
        _openTime = State(initialValue: salonDetails.openTime?.convertToTime() ?? Date())
        _closeTime = State(initialValue: salonDetails.closeTime?.convertToTime() ?? Date())
        _waitTime = State(initialValue: salonDetails.waitTime?.convertToString() ?? "10.0" )
        _salonName = State(initialValue: salonDetails.salonName)
        if let serviceList = salonDetails.serviceList, serviceList.count > 0 {
            checkInDetailViewModel.selectedServices = converListToSelectedService(serviceList: serviceList)
            checkInDetailViewModel.checkInDetailModel.servicesList = checkInDetailViewModel.updateServiceList(salonDetails: salonDetails)
            updateCategoryText()
        }
    }
    
    func converListToSelectedService(serviceList: [[String : [String]]]) -> [SelectedServiceInput] {
        let selectedService = serviceList.map { service in
            for (key, value) in service {
                return SelectedServiceInput(categoryName: key, serviceList: value)
            }
            return SelectedServiceInput(categoryName: "", serviceList: [])
        }
        return selectedService
    }
}

struct SalonRegistationView_Previews: PreviewProvider {
    static var previews: some View {
        SalonRegistationView()
    }
}
