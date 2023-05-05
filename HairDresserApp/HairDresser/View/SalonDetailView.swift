//
//  SalonDetailView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 11/03/23.
//

import SwiftUI
import MapKit

struct SalonDetailView: View {
    var salonDetails: SalonDetails
    @State private var region: MKCoordinateRegion
    @State var annotations: [City] = []
    
    init(salonDetails: SalonDetails) {
        self.salonDetails = salonDetails
        let location =  CLLocationCoordinate2D(latitude: salonDetails.latitude ?? 0.0,
                                               longitude: salonDetails.longitude ?? 0.0)
        region = MKCoordinateRegion(center: location,
                                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        annotations = [City(name: salonDetails.salonName, coordinate: location)]
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                imageHeaderView
                Text(salonDetails.salonName)
                    .font(.title)
                getInfoView(imageName: "person", text: "Owner :", detail: salonDetails.ownerName)
                getInfoView(imageName: "phone", text: "Contact Number :", detail: salonDetails.contactNumber)
                getInfoView(imageName: "house", text: "Address:", detail: salonDetails.address)
                getInfoView(imageName: "stopwatch", text: "Open Time :", detail: salonDetails.openTime ?? "7 AM")
                getInfoView(imageName: "stopwatch", text: "Close Time:", detail: salonDetails.closeTime ?? "8 PM")
                let waitTime = salonDetails.waitTime ?? 10.0
                getInfoView(imageName: "stopwatch", text: "Wait Time :", detail: "\(waitTime.convertToString()) mins" )
                mapView
                checkInButton
            }.navigationTitle(salonDetails.salonName)
                .toolbarBackground(Constants.backgroundColor, for: .navigationBar)
            
        }.padding()
    }
    
    func getInfoView(imageName: String, text: String, detail: String) -> some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.primary)
            Text(text)
            Spacer()
            Text(detail)
        }
    }
    
    var imageHeaderView: some View {
        ScrollView(.horizontal) {
            HStack {
                if let imageURLS = salonDetails.imageURLs {
                    ForEach(imageURLS, id: \.self) { imageURL in
                        ZStack {
                            AsyncImage(url: URL(string: imageURL), scale: 2) { image in
                                image
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(10)
                                    .padding()
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.gray.opacity(0.5))
                                    .clipShape(Circle())
                                    .padding()
                            }
                        }
                    }
                }
            }
        }
    }
    
    var mapView: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: annotations) {
                MapMarker(coordinate: $0.coordinate)
            }
            .frame(height: 300)
        }
    }
    
    var checkInButton: some View {
        NavigationLink(destination: CheckInDetailView(salonDetails: salonDetails)) {
            HStack {
                Text("Check In")
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
            }.foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}
