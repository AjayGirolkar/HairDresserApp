//
//  MapView.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 28/03/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var viewModel: LocationManager
    //let landmarks: [Landmark]
    var mapLocation: SalonDetails?
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator(control: self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = viewModel.mapView
        view.delegate = context.coordinator
        view.showsUserLocation = true
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let uiview = uiView as? MKMapView {
            updateAnnotations(from: uiview)
        }
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        if let mapLocation = mapLocation,
           let latitude = mapLocation.latitude,
           let longitude = mapLocation.longitude {
            let annotation = MKPointAnnotation()
            let coordinates = CLLocationCoordinate2D(latitude: latitude,
                                                     longitude: longitude)
            let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinates, span: mapSpan)
            annotation.title = mapLocation.salonName
            annotation.coordinate = coordinates
            mapView.addAnnotation(annotation)
        }
        //let annotation = self.landmarks.map(LandmarkAnnotation.init)
        //mapView.addAnnotations(annotation)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapView
        
        init(control: MapView) {
            self.control = control
        }
        
        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
            if let annotationView = views.first {
                if let annotation = annotationView.annotation {
                    if annotation is MKUserLocation {
                        let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                        mapView.setRegion(region, animated: true)
                    }
                }
            }
        }
    }
}
