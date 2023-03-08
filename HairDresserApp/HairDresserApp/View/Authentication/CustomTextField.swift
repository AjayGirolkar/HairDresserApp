//
//  CustomTextField.swift
//  InstagramSwiftUI
//
//  Created by Girolkar, Ajay W on 03/03/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeHolderText: String
    let imageName: String
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeHolderText)
                    .autocorrectionDisabled()
                    .foregroundColor(Color.init(.white.withAlphaComponent(0.8)))
                    .padding(.leading, 40)
            }
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                TextField("", text: $text)
            }
        }.padding()
        .background(Color(.init(white: 1, alpha: 0.15)))
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("Email"), placeHolderText: "Enter email id", imageName: "envelope")
    }
}
