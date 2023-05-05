//
//  OwnerTabView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 25/04/23.
//

import SwiftUI

struct OwnerTabView: View {
    @State var selectedIndex: Int = 0
    var user: User
    @ObservedObject var locationManager = LocationManager()
    
    init(user: User) {
        UITabBar.appearance().backgroundColor = UIColor(Constants.backgroundColor)
        self.user = user
        locationManager.requestLocation()
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedIndex) {
                SalonListView(user: user, locationManager: locationManager)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }.tag(0)
                SalonRegistationView()
                    .tabItem {
                        Image(systemName: "plus.app.fill")
                    }.tag(1)
                NotificationsView()
                    .tabItem {
                        Image(systemName: "bell")
                    }.tag(2)
                MoreDetailView(user: user)
                    .tabItem {
                        Image(systemName: "ellipsis")
                    }.tag(3)
            }
            //.accentColor(Color(uiColor: UIColor.prim))
            .background(Constants.screenBackgroundColor)
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Constants.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    var navigationTitle: String {
        switch selectedIndex {
        case 0: return "Salon Details"
        case 1: return "Register Salon"
        case 2: return "Notifications"
        case 3: return "More"
        default: return "Title"
        }
    }
}

struct OwnerTabView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerTabView(user: Constants.placeHolderUser)
    }
}
