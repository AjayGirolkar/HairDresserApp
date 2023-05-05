//
//  CustomMapView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 28/03/23.
//

import SwiftUI
import CoreLocation

struct CustomMapView: View {
    // @State var searchText: String = ""
    @State var isEditing: Bool = false
    @ObservedObject var locationManager: LocationManager
   
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                searchBarView
                if locationManager.showLocationList {
                    PlaceListView(landmarks: locationManager.landmarks) { selectedLandmark in
                        locationManager.showLocationList = false
                        locationManager.updateMapWithLandMark(landmark: selectedLandmark)
                    }
                }
                MapView(mapLocation: locationManager.mapLocation)
                    .frame(maxHeight: .infinity)
                    .environmentObject(locationManager)
                    .ignoresSafeArea()
                locationPreviewStack
            }
        }.onAppear{
            locationManager.focusLocation()
        } .alert(isPresented: $locationManager.permisionDenied) {
            alertView
        }
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(locationManager.salonDetails) { salonDetail in
                if locationManager.mapLocation == salonDetail {
                     LocationPreviewView(salonDetails: salonDetail, locationManager: locationManager)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}

extension CustomMapView {
    
    private var searchBarView: some View {
        SearchBar(searchText: $locationManager.searchedText, isEditing: $isEditing)
            .onChange(of: locationManager.searchedText, perform: { newValue in
                locationManager.getNearByLocation()
            })
            .padding(.horizontal)
            .shadow(color: .black.opacity(0.3), radius: 20)
            .background(Color(uiColor: UIColor.systemBackground).blur(radius: 20))
    }
    
    private var fillButton: some View {
        Button {
            locationManager.focusLocation()
        } label: {
            Image(systemName: "location.fill")
                .font(.title2)
                .background(Color.primary)
                .padding(10)
                .clipShape(Circle())
        }
    }
    
    private var updateMapTypeButton: some View {
        Button {
            locationManager.updateMapType()
        } label: {
            Image(systemName: locationManager.mapType == .standard ? "network" : "map")
                .font(.title2)
                .background(Color.primary)
                .padding(10)
                .clipShape(Circle())
        }
    }
    
    private var alertView: Alert {
        Alert(title: Text("Permission Denied"), message: Text("Please enable permission in App Setting"), dismissButton: .default(Text("Go to Setting"), action: {
            
            //Re-direct to app setting
            if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingURL)
            }
        }))
    }
}
