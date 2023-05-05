//
//  File.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 30/03/23.
//
import MapKit
import UIKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.title
        self.coordinate = landmark.coordinate
    }
}

