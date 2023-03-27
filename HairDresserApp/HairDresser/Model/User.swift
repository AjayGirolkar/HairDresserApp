//
//  User.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 10/03/23.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let email: String
    let fullname: String
    let profileImageUrl: String?
    
    var isCurrentUser: Bool {
        return AuthenticationViewModel.shared.user?.uid == id
    }
}

enum UserRole: String {
    case customer
    case owner
}
