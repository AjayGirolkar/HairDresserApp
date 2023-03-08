//
//  TabView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 06/03/23.
//

import SwiftUI

struct MainTabView: View {
    
    init() {
//        UITabBar.appearance().backgroundColor = UIColor.blue
//        UITabBar.appearance().barTintColor = .white
    }
    
    var body: some View {
        
        NavigationView {
            TabView {
                CheckInView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                SalonDirectoryView()
                    .tabItem {
                        Image(systemName: "location")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
                MoreDetailsView()
                    .tabItem {
                        Image(systemName: "ellipsis")
                    }
            }.navigationTitle("Hair Dresser")
                .accentColor(.black)
                .navigationBarTitleDisplayMode(.inline)
        }
       
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
