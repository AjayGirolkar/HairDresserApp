//
//  ProfileDetailViewModel.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import Foundation

class ProfileDetailViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
