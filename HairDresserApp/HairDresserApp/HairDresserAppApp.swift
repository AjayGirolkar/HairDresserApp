//
//  HairDresserAppApp.swift
//  HairDresserApp
//
//  Created by Lakshmi Sowjanya on 06/03/23.
//

import SwiftUI
import Firebase

@main
struct HairDresserAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
