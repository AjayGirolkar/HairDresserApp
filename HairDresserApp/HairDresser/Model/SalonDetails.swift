//
//  SalonDetails.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 11/03/23.
//

import FirebaseFirestoreSwift

struct SalonDetails: Identifiable, Decodable {
    @DocumentID var id: String?
    let salonName: String
    let email: String
    let contactNumber: String
    var address: String = ""
    let imageURL: String?
    let openTime: String?
    let closeTime: String?
    let waitTime: Double?
    let serviceList: [String]?
}
