//
//  CheckInViewModel.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI

class CheckInDetailViewModel: ObservableObject {
    @Published var checkInDetailModel = CheckInDetailModel(salonDetails: Example.salonDetailsExample, servicesList: [])
    @Published var selectedServices: [SelectedServiceInput] = []
    @Published var showContinueButton: Bool = false

    init() {
        getData()
    }
    
    func getData() {
        self.checkInDetailModel = Example.checkInDetailViewModel
    }
    
    func checkBoxAction(id: String, category: String, isSelected: Bool) {
        print("checkBoxAction clicked")
        for (serviceIndex, service) in checkInDetailModel.servicesList.enumerated() {
            for (categoryIndex, categoryList) in service.categoryList.enumerated() {
                if categoryList.id == id {
                    self.checkInDetailModel.servicesList[serviceIndex].categoryList[categoryIndex].isChecked = isSelected
                    let categoryAvailableList = selectedServices.filter{$0.categoryName == category}
                      if categoryAvailableList.count > 0 {
                            for (index, selectedService) in selectedServices.enumerated() {
                                if selectedService.categoryName == category {
                                    var list = selectedService.serviceList
                                    if isSelected {
                                        list.append(categoryList.serviceName.lowercased())
                                    } else {
                                        list = list.filter{$0 != categoryList.serviceName.lowercased()}
                                    }
                                    selectedServices[index].serviceList = list
                                    if list.count == 0 {
                                        selectedServices.remove(at: index)
                                    }
                                }
                            }
                        } else {
                            let selectedServiceInput = SelectedServiceInput(categoryName: category, serviceList: [categoryList.serviceName.lowercased()])
                            selectedServices.append(selectedServiceInput)
                        }
                    updateContinueButtonState()
                    print(selectedServices)
                }
            }
        }
    }
    
    func updateContinueButtonState() {
        if selectedServices.count > 0 {
            self.showContinueButton = true
        } else {
            self.showContinueButton = false
        }
    }
}
