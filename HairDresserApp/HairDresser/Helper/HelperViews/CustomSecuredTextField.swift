//
//  CustomSecuredTextField.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 07/03/23.
//

import SwiftUI

struct CustomSecuredTextField: View {
    @Binding var text: String
    var placeHolderText: String
    var backgroundColor = Color.primary.opacity(0.15)
    var textColor = Color.primary
    var placeHolderColor = Color.primary.opacity(0.8)
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeHolderText)
                    .foregroundColor(placeHolderColor)
                    .padding(.leading, 40)
            }
            
            HStack {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(textColor)
                SecureField("", text: $text)
                    .foregroundColor(textColor)
            }
        }.padding()
            .background(backgroundColor)
    }
}

struct CustomSecuredTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecuredTextField(text: .constant(""), placeHolderText: "Password")
    }
}
