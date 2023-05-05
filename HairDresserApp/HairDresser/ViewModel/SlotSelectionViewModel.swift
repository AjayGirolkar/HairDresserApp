//
//  SlotSelectionViewModel.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 24/03/23.
//

import SwiftUI

class SlotSelectionViewModel: ObservableObject {
    
    @Published var gridDetailModel = [GridDetailModel]()
    @Published var showContinueButton: Bool = false
    @Published var userSelectionModel = UserSelectionModel()
    
    init() {
        getData()
    }
    
    func getData() {
        //calendar
        let calendarData = getDateModel()
        
        //stylish
        let stylishItems = [GridItemModel(title: "Next Available", description: nil, isSelected: false),
                            GridItemModel(title: "Alex", description: nil, isSelected: false),
                            GridItemModel(title: "John", description: nil, isSelected: false),
                            GridItemModel(title: "Roy", description: nil, isSelected: false)]
        
        let stylishData = GridDetailModel(header: "Stylish",
                                          gridType: .stylish,
                                          gridItems: stylishItems,
                                          callBack: itemSelectionCallBack)
        
        //Checkin
        let checkInItems = [GridItemModel(title: "12 pm", isSelected: false),
                            GridItemModel(title: "1 pm", isSelected: false),
                            GridItemModel(title: "2 pm", isSelected: false),
                            GridItemModel(title: "3 am", isSelected: false),
                            GridItemModel(title: "4 pm", isSelected: false),
                            GridItemModel(title: "5 pm", isSelected: false),
                            GridItemModel(title: "6 pm", isSelected: false),
                            GridItemModel(title: "7 am", isSelected: false),
                            GridItemModel(title: "8 pm", isSelected: false),
                            GridItemModel(title: "9 pm", isSelected: false),
                            GridItemModel(title: "10 pm", isSelected: false)]
        
        let checkInData = GridDetailModel(header: "Check In Time",
                                          gridType: .checkInTime,
                                          gridItems: checkInItems,
                                          callBack: itemSelectionCallBack)
        
        gridDetailModel = [calendarData, stylishData, checkInData]
    }
    
    func getDateModel() -> GridDetailModel {
        let calendarItems = getCalendarItems()
        let calendarData = GridDetailModel(header: "Date",
                                           gridType: .calendar,
                                           gridItems: calendarItems,
                                           callBack: itemSelectionCallBack)
        return calendarData
    }
    
    func getCalendarItems() -> [GridItemModel] {
        var gridModelItems: [GridItemModel] = []
        let today = Date()
        for index in 0...7 {
            if let nextDate = today.dateAfterDay(count: index) {
                let date = nextDate.getDateNumber()
                let month = nextDate.dayOfWeek() ?? ""
                let completeDay = month + ", " + date
                let gridModel = GridItemModel(title: completeDay, date: nextDate, isSelected: false)
                gridModelItems.append(gridModel)
            }
        }
        return gridModelItems
    }
    
    func itemSelectionCallBack(gridType: GridType, id: String) {
        for (index, model) in gridDetailModel.enumerated() {
            if model.gridType == gridType {
                for (itemIndex, item) in model.gridItems.enumerated() {
                    if item.id == id {
                        let isSelected = !item.isSelected
                        self.gridDetailModel[index].gridItems[itemIndex].isSelected = isSelected
                        if isSelected {
                            updateUserSelectionModel(gridType: gridType, item: item)
                        } else {
                            updateUserSelectionModel(gridType: gridType, item: nil)
                        }
                    } else {
                        self.gridDetailModel[index].gridItems[itemIndex].isSelected = false
                    }
                }
            }
        }
    }
    
    func updateUserSelectionModel(gridType: GridType, item: GridItemModel?) {
        switch gridType {
        case .calendar:
            self.userSelectionModel.dateSelectedItem = item
        case .stylish:
            self.userSelectionModel.stylishSelectedItem = item
        case .checkInTime:
            self.userSelectionModel.checkInTimeSelectionModel = item
        }
        updateContinueButtonState()
    }
    
    func updateContinueButtonState() {
        if let _ = userSelectionModel.dateSelectedItem,
           let _ = userSelectionModel.stylishSelectedItem,
           let _ = userSelectionModel.checkInTimeSelectionModel {
            self.showContinueButton = true
        } else {
            self.showContinueButton = false
        }
    }
}
