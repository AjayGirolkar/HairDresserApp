//
//  CustomSegmentView.swift
//  HairDresserApp
//
//  Created by Ajay Girolkar on 07/03/23.
//

import SwiftUI

struct CustomSegmentView: View {
    
    @Binding var selectedId: String
    var values: [String] = []
    private let backgroundColor: Color = Color(.init(white: 1, alpha: 0.15))
    private let selectedSegmentColor: Color = Color.white
    private let selectedSegmentTintColor: Color = Color.black

    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(values, id: \.self) { value in
                    Button {
                        selectedId = value
                    } label: {
                        Text(value)
                            .frame(width: proxy.size.width / CGFloat(values.count), height: 30)
                            .foregroundColor(selectedId == value ? selectedSegmentTintColor : .white)
                            .background(selectedId == value ? selectedSegmentColor : Color.clear)
                            .clipShape(Capsule())
                    }
                }
            } .frame(width: proxy.size.width, height: 30)
                .background(backgroundColor)
                .clipShape(Capsule())
        }
    }
}
struct CustomSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSegmentView(selectedId: .constant(""))
    }
}
