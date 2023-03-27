//
//  Constants.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 07/03/23.
//

import Firebase
import SwiftUI

struct Constants {
    static let placeHolderUser = User(id: "", username: "", email: "", fullname: "", profileImageUrl: "")
    static let COLLECTION_USERS = Firestore.firestore().collection("users")
    static let backgroundColor = Color("backgroundColor")
    static let screenBackgroundColor = Color("screenBackgroundColor")
    static let textColor = Color("textColor")
    static let submitScreenModel = SubmitScreenModel(navigationTitle: "Please confirm you selection", salonDetailTitle: "Saloon Details: ", selectSlotTitle: "Verify selected slot: ", selectedDateTitle: "Selected Date and time", selectedStylishTitle: "Stylisher name:", submitButtonTitle: "Submit", selectedStylisherTitle: "Selected Services:", salonDetails: Example.salonDetailsExample, userSelectionModel: nil, selectedServiceList: [])
}

struct Example {
    static let salonDetailsExample = SalonDetails(salonName: "South Point Plaza", email: "southpointplaza@gmail.com", contactNumber: "+1-1234567", address: "121, New York, Blue Heaven Plaza", imageURL: nil, openTime: "7 am", closeTime: "10 pm", waitTime: 20.0, serviceList: ["Waxing", "Supercut", "Hair Cut", "Manicure", "Padicure", "Massage"])
    
    static let checkInDetailViewModel = CheckInDetailModel(salonDetails: Example.salonDetailsExample, servicesList: [ServiceDetails(categoryName: "Haircut",
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
                                                                                                                           CategoryList(isChecked: false, serviceName: "Supercut with Shampoo")])])
    
    static let userSelectionModel = UserSelectionModel(dateSelectedItem: GridItemModel(title: "Tue 6", isSelected: true), stylishSelectedItem: GridItemModel(title: "Alex", isSelected: true), checkInTimeSelectionModel: GridItemModel(title: "12 pm", isSelected: true))
    static let submitScreenModelExample = SubmitScreenModel(navigationTitle: "Please confirm you selection", salonDetailTitle: "Saloon Details: ", selectSlotTitle: "Verify selected slot: ", selectedDateTitle: "Selected Date and time", selectedStylishTitle: "Stylisher name:", submitButtonTitle: "Submit", selectedStylisherTitle: "Selected Services:", salonDetails: Example.salonDetailsExample, userSelectionModel: Example.userSelectionModel, selectedServiceList: [SelectedServiceInput(categoryName: "Waxing", serviceList: ["Waxing", "Hair Cut", "Massage"])])
}
