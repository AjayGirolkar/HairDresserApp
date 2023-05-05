//
//  CustomTextField.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 07/03/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeHolderText: String
    let imageName: String
    var backgroundColor = Color.primary.opacity(0.15)
    var textColor = Color.primary
    var placeHolderColor = Color.primary.opacity(0.8)
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeHolderText)
                    .autocorrectionDisabled()
                    .foregroundColor(placeHolderColor)
                    .padding(.leading, 40)
            }
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(textColor)
                TextField("", text: $text)
                    .foregroundColor(textColor)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
            }
        }.padding()
            .background(backgroundColor)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("Email"), placeHolderText: "Enter email id", imageName: "envelope")
    }
}
