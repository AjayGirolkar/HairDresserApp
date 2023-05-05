//
//  SlotSelectionView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 23/03/23.
//

import SwiftUI


struct SlotSelectionView: View {
    @ObservedObject var slotSelectionViewModel = SlotSelectionViewModel()
    private var selectedServices: [SelectedServiceInput] = []
    var salonDetails: SalonDetails
    
    init(salonDetails: SalonDetails, selectedServices: [SelectedServiceInput] = []) {
        self.selectedServices = selectedServices
        self.salonDetails = salonDetails
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    ForEach(0..<slotSelectionViewModel.gridDetailModel.count, id: \.self) { index in
                        let model = slotSelectionViewModel.gridDetailModel[index]
                        CustomGridView(gridDetailModel: model)
                    }
                }.navigationTitle("Select your slot for booking")
            } .padding()
            continueButton
        }
    }
    
    var continueButton: some View {
        VStack {
            NavigationLink(destination: SubmitScreenView(submitScreenModel: getSubmitDetailModel())) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .foregroundColor(!slotSelectionViewModel.showContinueButton ? Constants.textColor : .white)
            }.buttonStyle(.borderedProminent)
                .disabled(!slotSelectionViewModel.showContinueButton)
                .padding()
        }.background(Constants.backgroundColor)
    }
    
    func getSubmitDetailModel() -> SubmitScreenModel {
        var submitScreenModel = Constants.submitScreenModel
        submitScreenModel.userSelectionModel = slotSelectionViewModel.userSelectionModel
        submitScreenModel.selectedServiceList = selectedServices
        submitScreenModel.salonDetails = salonDetails
        return submitScreenModel
    }
}

struct SlotSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SlotSelectionView(salonDetails: Example.salonDetailsExample)
    }
}
