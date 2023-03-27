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
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeHolderText)
                    .foregroundColor(Color.init(.white.withAlphaComponent(0.8)))
                    .padding(.leading, 40)
            }
            
            HStack {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                SecureField("", text: $text)
            }
        }.padding()
        .background(Color(.init(white: 1, alpha: 0.15)))
    }
}

struct CustomSecuredTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecuredTextField(text: .constant(""), placeHolderText: "Password")
    }
}
