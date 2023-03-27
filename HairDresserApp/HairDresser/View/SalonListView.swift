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
    @ObservedObject var salonDetailViewModel = SalonDetailViewModel()
    @State var selectedSegmentId = "Shortest Distance"
    
    var salonList: [SalonDetails] {
        return searchedText.isEmpty ? salonDetailViewModel.salonDetails : salonDetailViewModel.filteredUser(query: searchedText)
    }
    
    var body: some View {
        VStack() {
            SearchBar(searchText: $searchedText, isEditing: $inSearchMode)
                .padding()
                .navigationTitle("Search")
            Divider()
            
            segmentView
                .frame(height: 30)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            ScrollView {
                LazyVStack {
                    ForEach(salonList) { salonDetails in
                        SalonDetailsCell(salonDetails: salonDetails)
                            .buttonStyle(PlainButtonStyle())
                        Divider()
                    }
                }
            }.padding(.horizontal)
                .background(Constants.backgroundColor)
        }
    }
    
    var segmentView: some View {
        VStack {
            CustomSegmentView(selectedId: $selectedSegmentId, values: ["Shortest Distance", "Shortest Wait Time"])
        }
    }
}

struct SalonListView_Previews: PreviewProvider {
    static var previews: some View {
        SalonListView()
    }
}
