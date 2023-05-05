//
//  Notification.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 05/04/23.
//

import FirebaseFirestoreSwift
import Firebase

enum NotificationType: Int, Decodable {
    case appointmentConfirmed
    case information
}

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String? = UUID().uuidString
    var customerId: String?
    var username: String?
    var message: String?
    var imageURL: String?
    var user: User?
    var salonImageUrl: String?
    var notificationType: NotificationType? = .appointmentConfirmed
    var appointmentId: String? = ""
}
