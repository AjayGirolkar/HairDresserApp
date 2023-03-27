//
//  SalonDetailsCell.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 11/03/23.
//

import SwiftUI

struct SalonDetailsCell: View {
    var salonDetails: SalonDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if let waitTime = salonDetails.waitTime {
                    Text("Estimated time: \(waitTime.convertToString()) min")
                    //estimated distance
                }
            }
            Text(salonDetails.salonName)
                .font(.title2)
                .fontWeight(.semibold)
            //address
            Text(salonDetails.address)
            Text(salonDetails.contactNumber)
            if let closeTime = salonDetails.closeTime {
                Text("Open until \(closeTime)")
            }
            getContactDetailsButtons()
        }.padding(.vertical, 8)
    }
    
    func getContactDetailsButtons() -> some View {
        HStack {
            NavigationLink(destination:  CheckInDetailView()) {
                HStack {
                    Text("Check In")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .frame(width: 150, height: 30)
                }.foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination:  SalonDetailView()) {
                Image(systemName: "book")
                    .frame(maxWidth: .infinity)
            }

            Button {
                print("Clicked call button")

            } label: {
                Image(systemName: "phone.fill")
                    .frame(maxWidth: .infinity)
            }
        }.padding(.vertical)
    }
}

struct SalonDetailsCell_Previews: PreviewProvider {
    static var previews: some View {
        SalonDetailsCell(salonDetails: SalonDetails(salonName: "", email: "", contactNumber: "", imageURL: "", openTime: "", closeTime: "", waitTime: 0, serviceList: [""]))
    }
}
