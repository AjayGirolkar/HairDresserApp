//
//  LocationPreviewView.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 22/04/23.
//

import SwiftUI

struct LocationPreviewView: View {
    var salonDetails: SalonDetails
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            VStack(spacing: 8) {
                NavigationLink(destination: SalonDetailView(salonDetails: salonDetails)) {
                    Text("Learn more")
                        .font(.headline)
                        .frame(width: 120, height: 35)
                }.buttonStyle(.borderedProminent)
                nextButton
            }
        }.padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y: 65)
            )
            .cornerRadius(10)
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imagrUrl = salonDetails.imageURLs?.first {
                AsyncImage(url: URL(string: imagrUrl), scale: 2) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.gray)
                        .padding()
                }
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View  {
        VStack(alignment: .leading, spacing: 4) {
            Text(salonDetails.salonName)
                .font(.title2)
                .fontWeight(.semibold)
            Text(salonDetails.address)
                .font(.subheadline)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
        
    private var nextButton: some View {
        Button {
            locationManager.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 120, height: 35)
        }.buttonStyle(.bordered)
    }
}
