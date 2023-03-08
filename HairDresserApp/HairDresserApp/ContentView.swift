//
//  ContentView.swift
//  HairDresserApp
//
//  Created by Lakshmi Sowjanya on 06/03/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel

    
    var body: some View {
        if authViewModel.user == nil {  //if not logged in show login screen
            LoginView()
        } else { //else show landing screen
            MainTabView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
