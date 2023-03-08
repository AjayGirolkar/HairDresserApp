//
//  MoreDetailsView.swift
//  HairDresserApp
//
//  Created by Ajay Girolkar on 08/03/23.
//

import SwiftUI

struct MoreDetailsView: View {
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

        }
    }
}

struct MoreDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreDetailsView()
    }
}
