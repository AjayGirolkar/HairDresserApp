//
//  CustomButtonView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 06/04/23.
//

import SwiftUI

struct CustomButtonView: View {
    var id: String
    var title: String
    var callBack: (String) -> Void
    var tintColor: Color = Constants.textColor
    var foregroundColor: Color = Constants.screenBackgroundColor
    
    var body: some View {
        Button {
            callBack(id)
        } label: {
            Text(title)
                .bold()
        }.buttonStyle(.borderedProminent)
            .foregroundColor(foregroundColor)
            .tint(tintColor)
            .frame(maxWidth: .infinity)
            .shadow(radius: 10)

    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(id: "", title: "Login", callBack: {_ in })
    }
}
