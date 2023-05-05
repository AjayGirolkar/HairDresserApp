//
//  CustomTimePickerView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 12/04/23.
//

import SwiftUI

struct CustomTimePickerView: View {
    @Binding var time: Date
    var text: String
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primary)
                DatePicker(text,
                           selection: $time,
                           displayedComponents: .hourAndMinute)
                .padding(.horizontal, 10)
            }
        }.padding()
        .background(Color.primary.opacity(0.15))
    }
}

struct CustomTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTimePickerView(time: .constant(Date.now), text: "Enter time", imageName: "")
    }
}
