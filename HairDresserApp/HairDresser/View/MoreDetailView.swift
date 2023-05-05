//
//  MoreDetailView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI

struct MoreDetailView: View {
    var user: User
    @State var showLogoutAlert: Bool = false
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        List {
            addNavigationView(text: "Profile", imageName: "person.fill", DestinationView: ProfileDetailView(user: user))
            
//            if user.userRoleType == .owner {
//                addNavigationView(text: "Register Salon", imageName: "scissors", DestinationView: SalonRegistationView())
//            }
            
            Button {
                showLogoutAlert = true
                
            } label: {
                HStack {
                    Text("Logout")
                    Spacer()
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
            }
        }.background(Constants.backgroundColor)
            .alert(isPresented: $showLogoutAlert) {
                alertView
            }
    }
}

extension MoreDetailView {
    private var alertView: Alert {
        Alert(title: Text("Logout?"),
              message: Text("Are you sure you want to Logout"),
              primaryButton: .destructive(Text("Yes")) {
            AuthenticationViewModel.shared.signout()
        },secondaryButton: .cancel()
        )
    }
    
    func addNavigationView(text: String, imageName: String, DestinationView: some View) -> some View {
        ZStack {
            HStack {
                Text(text)
                Spacer()
                Image(systemName: imageName)
            }.foregroundColor(.blue)
            
            NavigationLink(destination: DestinationView) {
                EmptyView()
            }.opacity(0)
        }
    }
}

struct MoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoreDetailView(user: Constants.placeHolderUser)
    }
}
