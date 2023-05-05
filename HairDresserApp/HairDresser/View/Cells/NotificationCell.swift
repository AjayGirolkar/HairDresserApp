//
//  NotificationCell.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 05/04/23.
//

import SwiftUI

struct NotificationCell: View {
    var notification: Notification
    var imageUrl = ""
    
    init(notification: Notification) {
        self.notification = notification
        if let user = AuthenticationViewModel.shared.currentUser,
           let userRoleType = user.userRoleType,
           userRoleType == .customer {
            imageUrl = notification.salonImageUrl ?? ""
        } else {
            imageUrl = notification.imageURL ?? ""
        }
    }
    var body: some View {
        VStack(alignment: .leading){
            switch notification.notificationType {
            case .appointmentConfirmed:
                appointmentView
            case .information:
                informationView
            case .none:
                Text("No new notification available.")
            }
        }.padding(8)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                //.blur(radius: 5)
            )
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
    }
}

extension NotificationCell {
    
    var appointmentView: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImageView(url: URL(string: imageUrl),
                               placeHolderImageName: "photo",
                               width: 50,
                               height: 50)
                .cornerRadius(10)
                .shadow(radius: 10)
                Text(notification.message ?? "")
                Spacer()
            }
        }.frame(maxWidth: .infinity)
    }
    
    var informationView: some View {
        VStack(alignment: .leading) {
            Text("Information view")
        }.frame(maxWidth: .infinity)
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell(notification: Notification())
    }
}
