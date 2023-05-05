//
//  SlotSelectionModel.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 25/03/23.
//

import Foundation

struct GridDetailModel {
    var header: String
    var gridType: GridType
    var gridItems: [GridItemModel]
    var callBack: (GridType, String) -> Void
}

struct GridItemModel {
    let id = UUID().uuidString
    var title: String
    var description: String?
    var date: Date?
    var isSelected: Bool
    
    func value() -> String {
        var title = title
        if let description = description {
            title = title + " " + description
        }
        return title
    }
}

struct UserSelectionModel {
    var dateSelectedItem: GridItemModel? = nil
    var stylishSelectedItem: GridItemModel? = nil
    var checkInTimeSelectionModel: GridItemModel? = nil
}


