//
//  SalonDetailsCell.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 11/03/23.
//

import SwiftUI

struct SalonDetailsCell: View {
    var salonDetails: SalonDetails
    var userRoleType: UserRole
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(salonDetails.salonName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                if let waitTime = salonDetails.waitTime {
                    getInfoView(imageName: "stopwatch", text: "Estimated wait time: \(waitTime.convertToString()) min")
                }
                if let distance = salonDetails.distance {
                    getInfoView(imageName: "car.rear.road.lane", text: "Distance: \(distance.convertToString()) Km")
                }
                
                //address
                getInfoView(imageName: "house", text: salonDetails.address)
                getInfoView(imageName: "phone", text: "Contact: \(salonDetails.contactNumber)")
                if let closeTime = salonDetails.closeTime {
                    getInfoView(imageName: "stopwatch", text: "Open until: \(closeTime)")
                }
                getContactDetailsButtons()
            }.padding(.horizontal)
        }.padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .blur(radius: 5)
            )
            .cornerRadius(10)
        
    }
    
    var checkInDetailView: some View {
        NavigationLink(destination: CheckInDetailView(salonDetails: salonDetails)) {
            HStack {
                Text("Check In")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .frame(width: 150, height: 30)
            }.foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    
    var editSalonView: some View {
        NavigationLink(destination: NavigationLazyView(SalonRegistationView(salonDetails: salonDetails, isUpdate: true))) {
            HStack {
                Text("Edit")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .frame(width: 150, height: 30)
            }.foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    func getContactDetailsButtons() -> some View {
        HStack {
            if userRoleType == .customer {
                checkInDetailView
            } else {
                editSalonView
            }
            
            NavigationLink(destination:  SalonDetailView(salonDetails: salonDetails)) {
                Image(systemName: "book")
                    .frame(maxWidth: .infinity)
            }
            contactView
        }.padding(.vertical)
    }
    
    func getInfoView(imageName: String, text: String) -> some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.primary)
            Text(text)
            Spacer()
        }
    }
}

extension SalonDetailsCell {
    var contactView: some View {
        HStack {
            let phone = "tel:"
            let phoneNumberformatted = phone + salonDetails.contactNumber
            if let url = URL(string: phoneNumberformatted) {
                Link(destination: url) {
                    Image(systemName: "phone.fill")
                        .frame(maxWidth: .infinity)
                }
            }
            
        }
    }
}

struct SalonDetailsCell_Previews: PreviewProvider {
    static var previews: some View {
        SalonDetailsCell(salonDetails: SalonDetails(salonName: "",  ownerName: "", email: "",
                                                    contactNumber: "", imageURLs: [""], openTime: "",
                                                    closeTime: "", waitTime: 0, latitude: 0.0,
                                                    longitude: 1.0, serviceList: [["" : []]]),
                         userRoleType: .customer)
    }
}
