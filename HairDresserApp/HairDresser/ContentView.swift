//
//  ContentView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        if authViewModel.user == nil {  //if not logged in show login screen
            LoginView()
        } else { //else show landing screen
            if let currentUser = authViewModel.currentUser,
               let userRole = currentUser.userRoleType{ //else show landing screen
                if userRole == .customer {
                    CustomerTabView(user: currentUser)
                } else {
                    OwnerTabView(user: currentUser)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
