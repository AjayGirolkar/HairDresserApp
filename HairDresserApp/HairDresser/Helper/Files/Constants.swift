//
//  Constants.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 07/03/23.
//

import Firebase
import SwiftUI

struct APIConstants {
    static let COLLECTION_USERS = Firestore.firestore().collection("users")
    static let collection_salonDetails = Firestore.firestore().collection("SalonDetails")
    static let collection_appointmentDetails = Firestore.firestore().collection("AppointmentDetails")
    static let collection_followers = Firestore.firestore().collection("followers")
    static let collection_following = Firestore.firestore().collection("following")
    static let collection_post = Firestore.firestore().collection("post")
    static let collection_notifications = Firestore.firestore().collection("notifications")
}

struct Constants {
    static let salonDetailsExample = Example.salonDetailsExample
    static let salonImageUrls = ["https://firebasestorage.googleapis.com:443/v0/b/hair-dresser-9e69e.appspot.com/o/salon_images%2F6A30BF16-7ECA-4DC9-9F09-06551F02BDBA%2Fsalon_images%2F0?alt=media&token=02f06e8f-88da-4c99-99b7-3de01bf4bcc8",
                                 "https://firebasestorage.googleapis.com:443/v0/b/hair-dresser-9e69e.appspot.com/o/salon_images%2F6A30BF16-7ECA-4DC9-9F09-06551F02BDBA%2Fsalon_images%2F4?alt=media&token=0a0cc5f2-7cd2-4433-b784-4760c5e45efb",
                                 "https://firebasestorage.googleapis.com:443/v0/b/hair-dresser-9e69e.appspot.com/o/salon_images%2F6A30BF16-7ECA-4DC9-9F09-06551F02BDBA%2Fsalon_images%2F2?alt=media&token=c66e1dbd-a9c0-48f1-96ef-3fbc28db8def",
                                 "https://firebasestorage.googleapis.com:443/v0/b/hair-dresser-9e69e.appspot.com/o/salon_images%2F6A30BF16-7ECA-4DC9-9F09-06551F02BDBA%2Fsalon_images%2F1?alt=media&token=bebc9529-e292-4e74-92ba-e7d417e907ad",
                                 "https://firebasestorage.googleapis.com:443/v0/b/hair-dresser-9e69e.appspot.com/o/salon_images%2F6A30BF16-7ECA-4DC9-9F09-06551F02BDBA%2Fsalon_images%2F3?alt=media&token=2bb1d5df-f044-4e9c-8b47-ff531af4a897"
    ]
    static let placeHolderUser = User(id: "", username: "", email: "", fullname: "", contactNumber: "", profileImageUrl: "")
    static let backgroundColor = Color("backgroundColor")
    static let screenBackgroundColor = Color("screenBackgroundColor")
    static let textColor = Color("textColor")
    static let submitScreenModel = SubmitScreenModel(navigationTitle: "Please confirm you selection", salonDetailTitle: "Salon Details: ", selectSlotTitle: "Verify selected slot: ", selectedDateTitle: "Selected Date and time", selectedStylishTitle: "Stylisher name:", submitButtonTitle: "Submit", selectedStylisherTitle: "Selected Services:", salonDetails: Example.salonDetailsExample, userSelectionModel: nil, selectedServiceList: [])
}

struct Example {
    static let salonDetailsExample = SalonDetails(salonName: "South Point Plaza", ownerName: "Roy", email: "southpointplaza@gmail.com", contactNumber: "+1-1234567", address: "121, New York, Blue Heaven Plaza", imageURLs: nil, openTime: "7 am", closeTime: "10 pm", waitTime: 20.0,  latitude: 40.7128, longitude: -73.935242, serviceList: [["Hair cut": ["Supercut", "Supercut with Shampoo"]], ["Waxing": ["Waxing", "Full body waxing"]], ["Glazing" : ["Supercool"]], ["Cleaning": ["Manicure", "Padicure"]], ["Hair Color": ["Root touch up", "Full color", "Bleach and tone"]]])
    
    static let servicesList = [ServiceDetails(categoryName: "Haircut",
                                              categoryList: [CategoryList(isChecked: false, serviceName: "Supercut"),
                                                             CategoryList(isChecked: false, serviceName: "Supercut with Shampoo")]),
                               ServiceDetails(categoryName: "Waxing",
                                              categoryList: [CategoryList(isChecked: false, serviceName: "Waxing"),
                                                             CategoryList(isChecked: false, serviceName: "Full body waxing")]),
                               ServiceDetails(categoryName: "Glazing",
                                              categoryList: [CategoryList(isChecked: false, serviceName: "Supercool")]),
                               ServiceDetails(categoryName: "Haircut",
                                              categoryList: [CategoryList(isChecked: false, serviceName: "Supercut"),
                                                             CategoryList(isChecked: false, serviceName: "Supercut with Shampoo")]),
                               ServiceDetails(categoryName: "Haircut",
                                              categoryList: [CategoryList(isChecked: false, serviceName: "Supercut"),
                                                             CategoryList(isChecked: false, serviceName: "Supercut with Shampoo")]),
                               ServiceDetails(categoryName: "Haircut",
                                              categoryList: [CategoryList(isChecked: false, serviceName: "Supercut"),
                                                             CategoryList(isChecked: false, serviceName: "Supercut with Shampoo")])]
    
    static let checkInDetailViewModel = CheckInDetailModel(salonDetails: Example.salonDetailsExample, servicesList: Example.servicesList)
    
    static let userSelectionModel = UserSelectionModel(dateSelectedItem: GridItemModel(title: "Tue 6", isSelected: true), stylishSelectedItem: GridItemModel(title: "Alex", isSelected: true), checkInTimeSelectionModel: GridItemModel(title: "12 pm", isSelected: true))
    static let submitScreenModelExample = SubmitScreenModel(navigationTitle: "Please confirm you selection", salonDetailTitle: "Salon Details: ", selectSlotTitle: "Verify selected slot: ", selectedDateTitle: "Selected Date and time", selectedStylishTitle: "Stylisher name:", submitButtonTitle: "Submit", selectedStylisherTitle: "Selected Services:", salonDetails: Example.salonDetailsExample, userSelectionModel: Example.userSelectionModel, selectedServiceList: [SelectedServiceInput(categoryName: "Waxing", serviceList: ["Waxing", "Hair Cut", "Massage"])])
    
    static let notifications = [Notification(username: "User",
                                             message: "Your appointment has been confirmed",
                                             imageURL: "",
                                             user: Constants.placeHolderUser),
                                Notification(username: "User",
                                             message: "Your appointment has been confirmed",
                                             imageURL: "",
                                             user: Constants.placeHolderUser,
                                             notificationType: .information)]
    static func getSalonDetails() -> [SalonDetails] {
        return  [SalonDetails(id: "1",
                              salonName: "Modern Salon",
                              ownerName: "Jack",
                              email: "modernsalon@gmail.com",
                              contactNumber: "(+1) 91223412",
                              address: "12, Sky High Tower, New York, 100001",
                              imageURLs:  Constants.salonImageUrls,
                              openTime: "7 am",
                              closeTime: "10 pm",
                              waitTime: 30,
                              latitude: 40.7128,
                              longitude: -73.935242,
                              serviceList: [["Hair cut": ["Supercut", "Supercut with Shampoo"]],
                                            ["Waxing": ["Waxing", "Full body waxing"]],
                                            ["Glazing" : ["Supercool"]],
                                            ["Cleaning": ["Manicure", "Padicure"]],
                                            ["Hair Color": ["Root touch up", "Full color", "Bleach and tone"]]]),
                 SalonDetails(id: "2",
                              salonName: "Fashion Salon",
                              ownerName: "Jack",
                              email: "fashionnsalon@gmail.com",
                              contactNumber: "(+1) 91223412",
                              address: "12, Sky High Tower, New York, 100001",
                              imageURLs:  Constants.salonImageUrls,
                              openTime: "7 am",
                              closeTime: "10 pm",
                              waitTime: 20,
                              latitude: 40.7128,
                              longitude: -73.935242,
                              serviceList: [["Hair cut": ["Supercut", "Supercut with Shampoo"]],
                                            ["Waxing": ["Waxing", "Full body waxing"]],
                                            ["Glazing" : ["Supercool"]],
                                            ["Cleaning": ["Manicure", "Padicure"]],
                                            ["Hair Color": ["Root touch up", "Full color", "Bleach and tone"]]]),
                 SalonDetails(id: "3",
                              salonName: "Unique Salon",
                              ownerName: "Jack",
                              email: "uniquesalon@gmail.com",
                              contactNumber: "(+1) 91223412",
                              address: "12, Sky High Tower, New York, 100001",
                              imageURLs:  Constants.salonImageUrls,
                              openTime: "7 am",
                              closeTime: "10 pm",
                              waitTime: 10,
                              latitude: 40.7128,
                              longitude: -73.935242,
                              serviceList: [["Hair cut": ["Supercut", "Supercut with Shampoo"]],
                                            ["Waxing": ["Waxing", "Full body waxing"]],
                                            ["Glazing" : ["Supercool"]],
                                            ["Cleaning": ["Manicure", "Padicure"]],
                                            ["Hair Color": ["Root touch up", "Full color", "Bleach and tone"]]]),
                 SalonDetails(id: "4",
                              salonName: "Modern Salon",
                              ownerName: "Jack",
                              email: "modernsalon@gmail.com",
                              contactNumber: "(+1) 91223412",
                              address: "12, Sky High Tower, New York, 100001",
                              imageURLs:  Constants.salonImageUrls,
                              openTime: "7 am",
                              closeTime: "10 pm",
                              waitTime: 45,
                              latitude: 40.7128,
                              longitude: -73.935242,
                              serviceList: [["Hair cut": ["Supercut", "Supercut with Shampoo"]],
                                            ["Waxing": ["Waxing", "Full body waxing"]],
                                            ["Glazing" : ["Supercool"]],
                                            ["Cleaning": ["Manicure", "Padicure"]],
                                            ["Hair Color": ["Root touch up", "Full color", "Bleach and tone"]]])]
    }
}
