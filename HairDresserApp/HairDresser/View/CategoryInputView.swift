//
//  CategoryInputView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 12/04/23.
//

import SwiftUI

struct CategoryInputView: View {

    @ObservedObject var checkInDetailViewModel: CheckInDetailViewModel
   
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Select Salon Categories")
                .font(.title)
            ScrollView {
                LazyVStack {
                    ForEach(checkInDetailViewModel.checkInDetailModel.servicesList) { serviceDetails in
                        getCategoryView(serviceDetails: serviceDetails)
                    }
                }
            }
            Spacer()
            footerView
        }.padding()
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
    
    var addButtonButton: some View {
        VStack {
            Button {
               
            } label: {
                Text("Add")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
            }.buttonStyle(.bordered)
        }.background(Constants.backgroundColor)
            .padding()
    }
    
    var footerView: some View {
        HStack {
            clearButton
            continueButton
        }
    }
    
    var continueButton: some View {
        VStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
            }.buttonStyle(.borderedProminent)
        }.background(Constants.backgroundColor)
            .padding()
    }
    
    var clearButton: some View {
        VStack {
            Button {
                checkInDetailViewModel.clearAllSelection()
            } label: {
                Text("Clear all")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
            }.buttonStyle(.bordered)
        }.background(Constants.backgroundColor)
            .padding()
    }
}

struct CategoryInputView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryInputView(checkInDetailViewModel: CheckInDetailViewModel(salonDetails: Example.salonDetailsExample))
    }
}
