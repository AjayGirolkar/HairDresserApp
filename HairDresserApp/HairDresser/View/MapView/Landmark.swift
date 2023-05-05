//
//  Landmark.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 30/03/23.
//

import MapKit

struct Landmark: Identifiable, Equatable {
    
    let placemark: MKPlacemark
    var id: String = UUID().uuidString
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
    
}

