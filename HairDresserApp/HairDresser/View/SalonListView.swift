//
//  SalonListView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI

struct SalonListView: View {
    @State var searchedText: String = ""
    @State var inSearchMode: Bool = false
    @StateObject var salonDetailViewModel = SalonDetailViewModel()
    @State var selectedSegmentId = "Shortest Distance"
    var user: User
    @ObservedObject var locationManager: LocationManager
    var isOwner: Bool {
        user.userRoleType == .owner
    }
    
    var salonList: [SalonDetails] {
        return searchedText.isEmpty ? salonDetailViewModel.salonDetails : salonDetailViewModel.filteredUser(query: searchedText)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            Divider()
            
            segmentView
                .frame(height: 30)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            ScrollView {
                LazyVStack {
                    ForEach(salonList, id: \.id) { salonDetails in
                        SalonDetailsCell(salonDetails: salonDetails, userRoleType: user.userRoleType ?? .customer)
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }.padding(.horizontal)
                .background(Constants.screenBackgroundColor)
        }.onAppear{
            salonDetailViewModel.userLocation = locationManager.location
            salonDetailViewModel.getData { isSuccess, error in
                print(isSuccess)
            }
        }
    }
    
    var headerView: some View {
        VStack(alignment: .leading) {
            let title =  isOwner ? "Your List of Salons" : "Search from our Salon List"
            Text(title)
                .font(.system(size: isOwner ? 24 : 18, weight: .semibold))
                .padding(.top)
                .padding(.horizontal)
            SearchBar(searchText: $searchedText, isEditing: $inSearchMode)
                .padding(.horizontal)
                .navigationTitle("Search")
        }
    }
    
    var segmentView: some View {
        VStack {
            CustomSegmentView(selectedId: $selectedSegmentId, values: ["Shortest Distance", "Shortest Wait Time"])
                .onChange(of: selectedSegmentId) { newValue in
                    if newValue == "Shortest Distance" {
                        salonDetailViewModel.filteredUserForShortestDistance()
                    } else {
                        salonDetailViewModel.filteredUserForShortestWaitTime()
                    }
                }
        }
    }
}

struct SalonListView_Previews: PreviewProvider {
    static var previews: some View {
        SalonListView(user: Constants.placeHolderUser, locationManager: LocationManager())
    }
}
