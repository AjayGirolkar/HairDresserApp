//
//  SalonListViewModel.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI

class SalonDetailViewModel: ObservableObject {
    @Published var salonDetails: [SalonDetails] = []
    
    init() {
        getSalonDetails()
    }
    
    func filteredUser(query: String) -> [SalonDetails] {
        let lowerCaseText = query.lowercased()
        return salonDetails.filter{($0.salonName.lowercased().contains(lowerCaseText) || $0.address.lowercased().contains(lowerCaseText))}
    }
    
    func getSalonDetails() {
        salonDetails = [SalonDetails(id: "1",
                                     salonName: "Modern Salon",
                                     email: "modernsalon@gmail.com",
                                     contactNumber: "(+1) 91223412",
                                     address: "12, Sky High Tower, New York, 100001",
                                     imageURL: "",
                                     openTime: "7 am",
                                     closeTime: "10 pm",
                                     waitTime: 30,
                                     serviceList: ["Hair cut", "Waxing", "Manicure", "Paddicure", "Shampoo"]),
                        SalonDetails(id: "2",
                                     salonName: "Fashion Salon",
                                     email: "fashionnsalon@gmail.com",
                                     contactNumber: "(+1) 91223412",
                                     address: "12, Sky High Tower, New York, 100001",
                                     imageURL: "",
                                     openTime: "7 am",
                                     closeTime: "10 pm",
                                     waitTime: 20,
                                     serviceList: ["Hair cut", "Waxing", "Manicure", "Paddicure", "Shampoo"]),
                        SalonDetails(id: "3",
                                     salonName: "Unique Salon",
                                     email: "uniquesalon@gmail.com",
                                     contactNumber: "(+1) 91223412",
                                     address: "12, Sky High Tower, New York, 100001",
                                     imageURL: "",
                                     openTime: "7 am",
                                     closeTime: "10 pm",
                                     waitTime: 10,
                                     serviceList: ["Hair cut", "Waxing", "Manicure", "Paddicure", "Shampoo"]),
                        SalonDetails(id: "4",
                                     salonName: "Modern Salon",
                                     email: "modernsalon@gmail.com",
                                     contactNumber: "(+1) 91223412",
                                     address: "12, Sky High Tower, New York, 100001",
                                     imageURL: "",
                                     openTime: "7 am",
                                     closeTime: "10 pm",
                                     waitTime: 45,
                                     serviceList: ["Hair cut", "Waxing", "Manicure", "Paddicure", "Shampoo"])]
    }
}
