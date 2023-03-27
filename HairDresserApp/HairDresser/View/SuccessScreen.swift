//
//  SuccessScreenView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 25/03/23.
//

import SwiftUI

struct SuccessScreenView: View {
    var submitScreenModel: SubmitScreenModel

    private var saloonName: String {
        submitScreenModel.salonDetails.salonName
    }
    private var dateAndTime: String {
        let date = submitScreenModel.userSelectionModel?.dateSelectedItem?.title ?? ""
        let time = submitScreenModel.userSelectionModel?.checkInTimeSelectionModel?.title ?? ""
        return date + " at " + time
    }
    
    var body: some View {
        VStack {
            Text("Success")
                .foregroundColor(.blue)
                .fontWeight(.bold)
                .font(.title)
            
            Spacer(minLength: 30)
            
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.green)
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
            Spacer(minLength: 30)
            Text("Your booking is confirm for ") + Text(saloonName).fontWeight(.semibold) + Text(" on ") + Text(dateAndTime).fontWeight(.semibold) + Text(". Please visit Saloon on given time.")
            Spacer()
            continueButton
        }.padding()
            .navigationBarBackButtonHidden(true)
    }
    
    var continueButton: some View {
        VStack {
            Button {
                NavigationUtil.popToRootView()
            } label: {
                Text("Dismiss")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
            }.buttonStyle(.borderedProminent)
        }.background(Constants.backgroundColor)
            .padding()
    }
}

struct SuccessScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessScreenView(submitScreenModel: Example.submitScreenModelExample)
    }
}
