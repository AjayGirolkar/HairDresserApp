//
//  SubmitScreenView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 25/03/23.
//

import SwiftUI

struct SubmitScreenView: View {
    
    var submitScreenModel: SubmitScreenModel = Example.submitScreenModelExample

    init(submitScreenModel: SubmitScreenModel) {
        self.submitScreenModel = submitScreenModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ScrollView {
                
                confirmHeader
                saloonDetailView
                slotDetailView
                serviceListDetailView
            }
        }.padding()
            .background(Constants.screenBackgroundColor)
        submitButton
    }
    
    var confirmHeader: some View {
        Text(submitScreenModel.navigationTitle)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(Constants.textColor)
    }
    
    var saloonDetailView: some View {
        VStack(alignment: .leading) {
            //header
            HStack {
                Text(submitScreenModel.salonDetailTitle)
                    .foregroundColor(Constants.textColor)
                    .fontWeight(.semibold)
                    .padding(10)
                Spacer()
            }.frame(maxWidth: .infinity)
                .background(Constants.backgroundColor)
            
            //Addess
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .top) {
                    Text("Saloon name : ")
                    Spacer()
                    Text(submitScreenModel.salonDetails.salonName)
                        .fontWeight(.semibold)
                }.padding()
                HStack(alignment: .top) {
                    Text("Saloon address : ")
                    Spacer()
                    Text(submitScreenModel.salonDetails.address)
                        .fontWeight(.semibold)
                }.padding()
                HStack(alignment: .top) {
                    Text("Contact number : ")
                    Spacer()
                    Text(submitScreenModel.salonDetails.contactNumber)
                        .fontWeight(.semibold)
                }.padding()
            } .background(Constants.screenBackgroundColor)
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
    
    var slotDetailView: some View {
        VStack(alignment: .leading) {
            //header
            HStack {
                Text(submitScreenModel.selectSlotTitle)
                    .foregroundColor(Constants.textColor)
                    .fontWeight(.semibold)
                    .padding(10)
                Spacer()
            }.frame(maxWidth: .infinity)
                .background(Constants.backgroundColor)
            
            //Addess
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .top) {
                    Text("Appointment Date :")
                    Spacer()
                    let title = submitScreenModel.userSelectionModel?.dateSelectedItem?.title ?? ""
                    let description = submitScreenModel.userSelectionModel?.dateSelectedItem?.description ?? ""
                    Text(title + " " + description)
                        .fontWeight(.semibold)
                }.padding()
                HStack(alignment: .top) {
                    Text("Appointment time : ")
                    Spacer()
                    Text(submitScreenModel.userSelectionModel?.checkInTimeSelectionModel?.title ?? "")
                        .fontWeight(.semibold)
                }.padding()
                HStack(alignment: .top) {
                    Text("Stylisher Name : ")
                    Spacer()
                    Text(submitScreenModel.userSelectionModel?.stylishSelectedItem?.title ?? "")
                        .fontWeight(.semibold)
                }.padding()
                
            }.padding()
                .background(Constants.screenBackgroundColor)
                .frame(maxWidth: .infinity)
        }
    }
    
    var serviceListDetailView: some View {
        VStack(alignment: .leading) {
            //header
            HStack(alignment: .top) {
                Text(submitScreenModel.selectedStylisherTitle)
                    .foregroundColor(Constants.textColor)
                    .fontWeight(.semibold)
                    .padding(10)
                Spacer()
            }.frame(maxWidth: .infinity)
                .background(Constants.backgroundColor)
            
            //Addess
            VStack(alignment: .leading, spacing: 5) {
                ForEach(0..<submitScreenModel.selectedServiceList.count, id: \.self) { index in
                    let selectedServiceList = submitScreenModel.selectedServiceList[index]
                    HStack(alignment: .top) {
                        Text(selectedServiceList.categoryName + " :")
                        Spacer()
                        VStack(alignment: .trailing) {
                            ForEach(selectedServiceList.serviceList, id: \.self) { item in
                                Text(item)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }.padding()
                
            }.padding()
                .background(Constants.screenBackgroundColor)
                .frame(maxWidth: .infinity)
        } .frame(maxWidth: .infinity)
    }
    
    var submitButton: some View {
        VStack {
            NavigationLink(destination: SuccessScreenView(submitScreenModel: submitScreenModel)) {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }.buttonStyle(.borderedProminent)
                .padding()
        }.background(Constants.backgroundColor)
    }
}

struct SubmitScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitScreenView(submitScreenModel: Example.submitScreenModelExample)
    }
}
