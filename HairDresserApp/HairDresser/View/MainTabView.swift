//
//  MainTabView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 11/03/23.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedIndex: Int = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                CheckInView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }.tag(0)
                SalonListView()
                    .tabItem {
                        Image(systemName: "location")
                    }.tag(1)
                ProfileDetailView()
                    .tabItem {
                        Image(systemName: "person.fill")
                    }.tag(2)
                MoreDetailView()
                    .tabItem {
                        Image(systemName: "ellipsis")
                    }.tag(3)
            }
            //.accentColor(Color(uiColor: UIColor.prim))
            .background(Constants.screenBackgroundColor)
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var navigationTitle: String {
        switch selectedIndex {
        case 0: return "Check Me In"
        case 1: return "Explore"
        case 2: return "Profile"
        case 3: return "More"
        default: return "Title"
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
