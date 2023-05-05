//
//  CustomerTabView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 25/04/23.
//

import SwiftUI

struct CustomerTabView: View {
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
                CustomMapView(locationManager: locationManager)
                    .tabItem {
                        Image(systemName: "location")
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
            .background(Constants.screenBackgroundColor)
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Constants.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    var navigationTitle: String {
        switch selectedIndex {
        case 0: return "Check Me In"
        case 1: return "Explore"
        case 2: return "Notifications"
        case 3: return "More"
        default: return "Title"
        }
    }
}

struct CustomerTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerTabView(user: Constants.placeHolderUser)
    }
}
