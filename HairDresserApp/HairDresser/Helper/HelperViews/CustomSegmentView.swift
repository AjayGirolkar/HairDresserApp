//
//  CustomSegmentView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 11/03/23.
//

import SwiftUI

struct CustomSegmentView: View {
    
    @Binding var selectedId: String
    var values: [String] = []
    private let backgroundColor: Color = Constants.backgroundColor
    private let selectedSegmentColor: Color = Constants.textColor
    private let selectedSegmentTintColor: Color = Constants.backgroundColor
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(values, id: \.self) { value in
                    Button {
                        selectedId = value
                    } label: {
                        Text(value)
                            .frame(width: proxy.size.width / CGFloat(values.count), height: 30)
                            .foregroundColor(selectedId == value ? selectedSegmentTintColor : Constants.textColor)
                            .background(selectedId == value ? selectedSegmentColor : backgroundColor)
                            .cornerRadius(15)
                    }
                }
            } .frame(width: proxy.size.width, height: 30)
                .background(backgroundColor)
                .cornerRadius(15)
                .animation(.default, value: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}
struct CustomSegmentView_Previews: PreviewProvider {
    struct Container: View {
        @State var selectedId = "one"
        var values = ["one", "two", "three"]
        var body: some View {
            CustomSegmentView(selectedId: $selectedId, values: values)
        }
    }
    static var previews: some View {
        Container()
            .padding()
    }
}
