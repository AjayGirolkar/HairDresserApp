//
//  NotificationViewModel.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 05/04/23.
//

import SwiftUI
import Firebase

class NotificationViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotificaitons()
    }
    
    func fetchNotificaitons() {
        guard let uid =  AuthenticationViewModel.shared.currentUser?.id else { return }
        let query = APIConstants.collection_notifications.document(uid).collection("user-notifications").order(by: "timestamp", descending: true)
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Erro in fetching Notifications: \(error.localizedDescription)")
            } else if let documents = snapshot?.documents {
                self.notifications = documents.compactMap({try? $0.data(as: Notification.self)})
            }
        }
    }
    
    static func uploadNotification(uid: String, message: String, type: NotificationType, salonDetails: SalonDetails) {
        guard let currentUser = AuthenticationViewModel.shared.currentUser,
              let customerId = currentUser.id else { return }
        let salonId = salonDetails.uid
        let salonImageUrl = salonDetails.imageURLs?.first ?? ""
        
        let data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "username": currentUser.username,
                                   "message": message,
                                   "imageURL": currentUser.profileImageUrl ?? "",
                                   "uid": uid,
                                   "customerId": customerId,
                                   "salonImageUrl": salonImageUrl,
                                   "notificationType": type.rawValue,
                                   "salonId": salonId]
        
        APIConstants.collection_notifications.document(uid).collection("user-notifications").addDocument(data: data) { error in
            if let error = error {
                print("Error in uploading noitifications: \(error.localizedDescription)")
            } else {
                print("Success: Uploaded Notificaiton")
            }
        }
    }
}
