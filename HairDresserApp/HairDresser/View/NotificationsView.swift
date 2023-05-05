//
//  NotificationsView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 05/04/23.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var notificationViewModel = NotificationViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 2) {
                if notificationViewModel.notifications.count > 0 {
                    ForEach(notificationViewModel.notifications) { notification in
                        NotificationCell(notification: notification)
                            .padding(.top)
                    }
                } else {
                    noNotificationView
                }
            }
        }.padding()
            .background(Constants.screenBackgroundColor)
    }
    
    var noNotificationView: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer(minLength: 100)
            Image(systemName: "bell.slash.fill")
                .resizable()
                .frame(width: 150, height: 150)
            Text("No Notification Available")
                .font(.headline)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
