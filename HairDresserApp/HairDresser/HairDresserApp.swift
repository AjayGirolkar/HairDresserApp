//
//  HairDresserApp.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI
import Firebase

@main
struct HairDresserApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthenticationViewModel.shared) //Shared object initialized
        }
    }
}
