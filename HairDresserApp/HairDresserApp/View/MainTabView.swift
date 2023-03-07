//
//  TabView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 06/03/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationView {
            TabView {
                CheckInView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                SearchResultView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                SalonDirectoryView()
                    .tabItem {
                        Image(systemName: "mappin")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
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
