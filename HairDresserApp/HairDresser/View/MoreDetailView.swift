//
//  MoreDetailView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI

struct MoreDetailView: View {
    var body: some View {
        List {
            Button {
                AuthenticationViewModel.shared.signout()
            } label: {
                HStack {
                    Text("Logout")
                    Spacer()
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
            }
        }.background(Constants.backgroundColor)
    }
}

struct MoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoreDetailView()
    }
}
