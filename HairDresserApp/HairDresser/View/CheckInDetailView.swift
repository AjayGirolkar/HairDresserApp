//
//  CheckInDetailView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 19/03/23.
//

import SwiftUI

struct CheckInDetailView: View {
    var salonDetails: SalonDetails
    @ObservedObject var checkInDetailViewModel: CheckInDetailViewModel
    @State var isChecked: Bool = false
    private let padding: CGFloat = 10
    private var checkInDetailModel: CheckInDetailModel {
        return checkInDetailViewModel.checkInDetailModel
    }
    
    init(salonDetails: SalonDetails) {
        self.salonDetails = salonDetails
        checkInDetailViewModel = CheckInDetailViewModel(salonDetails: salonDetails)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    VStack(alignment: .center, spacing: 5) {
                        Text(checkInDetailModel.salonDetails.salonName)
                            .font(.system(size: 14, weight: .semibold))
                        Text(checkInDetailModel.salonDetails.address)
                            .font(.system(size: 13, weight: .regular))
                    }
                    Divider()
                    ScrollView {
                        LazyVStack {
                            ForEach(checkInDetailModel.servicesList) { serviceDetails in
                                getCategoryView(serviceDetails: serviceDetails)
                            }
                        }
                    }
                    Spacer()
                }.padding(.horizontal)
                continueButton
                
            }.frame(minHeight: geometry.size.height, alignment: .top)
                .navigationTitle("Select Service")
                .background(Constants.screenBackgroundColor)
        }
        
    }
    
    func getCategoryView(serviceDetails: ServiceDetails) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(serviceDetails.categoryName)
                    .foregroundColor(Constants.textColor)
                    .fontWeight(.semibold)
                    .padding(10)
                Spacer()
            }.frame(maxWidth: .infinity)
            VStack(alignment: .leading, spacing: 20) {
                
                ForEach(0..<serviceDetails.categoryList.count,  id: \.self) { index in
                    let item = serviceDetails.categoryList[index]
                    HStack {
                        CheckBoxView(id: item.id, category: serviceDetails.categoryName, checked: item.isChecked, callBack: checkInDetailViewModel.checkBoxAction)
                        Text(item.serviceName)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
            }.padding(.horizontal, 5)
                .padding(.vertical, 10)
                .background(Constants.screenBackgroundColor)
        }.background(Constants.backgroundColor)
    }
    
    var continueButton: some View {
        VStack {
            NavigationLink(destination: SlotSelectionView(salonDetails: salonDetails,
                                                          selectedServices: checkInDetailViewModel.selectedServices)) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .foregroundColor(!checkInDetailViewModel.showContinueButton ? Constants.textColor : .white)
            }.buttonStyle(.borderedProminent)
                .disabled(!checkInDetailViewModel.showContinueButton)
                .padding()
        }.background(Constants.backgroundColor)
    }
}

struct CheckInDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInDetailView(salonDetails: Example.salonDetailsExample)
    }
}
