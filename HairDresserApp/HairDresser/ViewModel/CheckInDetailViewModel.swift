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
    
    init(salonDetails: SalonDetails) {
        let servicesList = updateServiceList(salonDetails: salonDetails)
        checkInDetailModel = CheckInDetailModel(salonDetails: salonDetails,
                                                servicesList: servicesList)
    }
    
    func updateServiceList(salonDetails: SalonDetails) -> [ServiceDetails] {
        var servicesDetails: [ServiceDetails] = []
        if let serviceList = salonDetails.serviceList {
            for services in serviceList {
                for (key, value) in services {
                    let isChecked = selectedServices.filter{$0.categoryName == key}.count > 0
                    servicesDetails.append(ServiceDetails(categoryName: key,
                                                          categoryList: value.map{ return CategoryList(isChecked: isChecked, serviceName: $0)}))
                }
            }
        }
        return servicesDetails
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
    
    func clearAllSelection() {
        selectedServices.removeAll()
        for (serviceIndex, service) in checkInDetailModel.servicesList.enumerated() {
            for (categoryIndex, _ ) in service.categoryList.enumerated() {
                self.checkInDetailModel.servicesList[serviceIndex].categoryList[categoryIndex].isChecked = false
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
