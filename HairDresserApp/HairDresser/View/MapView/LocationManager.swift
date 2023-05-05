//
//  LocationManager.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 30/03/23.
//

import SwiftUI
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var mapView = MKMapView()
    @Published var lastSearchedCity = ""
    @Published var permisionDenied: Bool = false
    @Published var region: MKCoordinateRegion!
    var hasFoundOnePlacemark:Bool = false
    @Published var location: CLLocation?
    @Published var mapType: MKMapType = .standard
    private var span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    
    @Published var searchedText: String = ""
    @Published var showLocationList: Bool = false
    @Published var landmarks:[Landmark] = [Landmark]()
    
    //Map
    @ObservedObject var salonDetailViewModel: SalonDetailViewModel = SalonDetailViewModel()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    var salonDetails: [SalonDetails] {
        salonDetailViewModel.salonDetails
    }
    
    @Published var showLocationSheet: SalonDetails? = nil
    @Published var mapLocation: SalonDetails? {
        didSet {
            if let mapLocation = mapLocation,
               let latitude = mapLocation.latitude,
               let longitude = mapLocation.longitude {
                let coordinates = CLLocationCoordinate2D(latitude: latitude,
                                                         longitude: longitude)
                let region = MKCoordinateRegion(center: coordinates, span: mapSpan)
                updateRegion(region: region)
            }
        }
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        salonDetailViewModel.getData { isSuccess, error in
            if isSuccess {
                self.mapLocation = self.salonDetailViewModel.salonDetails.first
            }
        }
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func getNearByLocation() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchedText
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
                
                self.showLocationList = self.landmarks.count > 0
                
            } else {
                self.showLocationList = false
            }
        }
    }
    
    func checkIfLocationServicesIsEnabled(){
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest/// kCLLocationAccuracyBest is the default
                self.checkLocationAuthorization()
            }else{
                // show message: Services desabled!
            }
        }
    }
    
    func updateRegion(region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }
    
    func updateMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    func focusLocation() {
        guard let _ = region else { return }
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    private func checkLocationAuthorization(){
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // show message
            permisionDenied = true
        case .denied:
            // show message
            permisionDenied = true
        case .authorizedWhenInUse, .authorizedAlways:
            /// app is authorized
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func updateMapWithLandMark(landmark: Landmark) {
        guard let location = landmark.placemark.location else { return }
        self.region = MKCoordinateRegion(center: location.coordinate,
                                         span: span)
        focusLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.region = MKCoordinateRegion(center: location.coordinate,
                                         span: span)
        hasFoundOnePlacemark = false
        focusLocation()
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)-> Void in
            if error != nil {
                self.locationManager.stopUpdatingLocation()
                // show error message
            }
            guard let placemarks = placemarks else { return }
            if placemarks.count > 0 {
                if !self.hasFoundOnePlacemark{
                    self.hasFoundOnePlacemark = true
                    let placemark = placemarks[0]
                    
                    self.lastSearchedCity = placemark.locality ?? ""
                }
                self.locationManager.stopUpdatingLocation()
            }else{
                // no places found
            }
        })
    }
    
    func nextButtonPressed() {
        guard let mapLocation = mapLocation,
              let currentIndex = salonDetails.firstIndex(of: mapLocation) else { return }
        let nextIndex = currentIndex + 1
        
        guard salonDetails.indices.contains(nextIndex) else {
            if let firstLocation = salonDetails.first {
                showNextLocation(salonDetails: firstLocation)
            }
            return
        }
        let nextLocation = salonDetails[nextIndex]
        self.showNextLocation(salonDetails: nextLocation)
    }
    
    func showNextLocation(salonDetails: SalonDetails) {
        withAnimation(.easeInOut) { //to show sliding animation for view
            self.mapLocation = salonDetails
            self.showLocationList = false
        }
    }
}

