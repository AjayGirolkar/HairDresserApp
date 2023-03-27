//
//  CheckBoxView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 19/03/23.
//

import SwiftUI

struct CheckBoxView: View {
    let id: String
    let category: String
    var checked: Bool
    var callBack: (String, String, Bool) -> Void
    
    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                callBack(id, category, !checked)
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(id: "", category: "", checked: true) { _, _, _ in  }
    }
}
