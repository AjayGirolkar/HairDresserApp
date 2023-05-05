//
//  SalonDetails.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 11/03/23.
//

import SwiftUI
import MapKit
import FirebaseFirestoreSwift

struct SalonDetailModel: Codable {
    var salonDetails: SalonDetails
}

struct SalonDetails: Identifiable, Codable, Equatable {
    var id: String?
    var uid: String = ""
    let salonName: String
    let ownerName: String
    let email: String
    let contactNumber: String
    var address: String = ""
    let imageURLs: [String]?
    let openTime: String?
    let closeTime: String?
    let waitTime: Double?
    let latitude: Double?
    let longitude: Double?
    var distance: Double? = 0.0
    let serviceList: [[String: [String]]]?
}

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
