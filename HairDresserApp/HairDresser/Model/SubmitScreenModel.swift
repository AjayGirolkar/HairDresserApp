//
//  SubmitScreenModel.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 25/03/23.
//

import Foundation

struct SubmitScreenModel {
    let navigationTitle: String
    let salonDetailTitle: String
    let selectSlotTitle: String
    let selectedDateTitle: String
    let selectedStylishTitle: String
    let submitButtonTitle: String
    var selectedStylisherTitle: String
    var salonDetails: SalonDetails
    var userSelectionModel: UserSelectionModel?
    var selectedServiceList: [SelectedServiceInput]
}
