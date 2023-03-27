//
//  CheckInDetailviewModel.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import Foundation

struct CheckInDetailModel {
    let salonDetails: SalonDetails
    var servicesList: [ServiceDetails]
}

struct ServiceDetails: Identifiable {
    let id: String = UUID().uuidString
    let categoryName: String
    var categoryList: [CategoryList]
}

struct CategoryList: Identifiable {
    let id: String = UUID().uuidString
    var isChecked: Bool
    let serviceName: String
}

struct SelectedServiceInput {
    var categoryName: String
    var serviceList: [String]
}
