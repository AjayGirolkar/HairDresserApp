//
//  SalonListViewModel.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 10/03/23.
//

import SwiftUI
import MapKit

class SalonDetailViewModel: ObservableObject {
    var userLocation: CLLocation?
    @Published var salonDetails: [SalonDetails] = []
    private var defaultSalonDetails: [SalonDetails] = []
    
    func getData(completion: @escaping (Bool, String?) -> Void) {
        FirebaseManager.getAllSalonList { success, error, salonList in
            if success,
               let salonList = salonList, salonList.count > 0 {
                let salonDetails = salonList.map({$0.salonDetails})
                self.salonDetails = salonDetails
                self.defaultSalonDetails = salonDetails
                self.updateDistanceFromUserLocation()
                self.filteredUserForShortestDistance()
                self.sortListForOwner()
                completion(true, nil)
            } else {
                completion(false, "Error")
            }
        }
    }
    
    func sortListForOwner() {
        guard let user = AuthenticationViewModel.shared.currentUser else { return }
        if user.userRoleType == .owner {
            salonDetails = salonDetails.filter({ $0.uid == user.id})
            defaultSalonDetails = salonDetails
        }
    }
    
    func filteredUser(query: String) -> [SalonDetails] {
        let lowerCaseText = query.lowercased()
        return salonDetails.filter{($0.salonName.lowercased().contains(lowerCaseText) || $0.address.lowercased().contains(lowerCaseText))}
    }
    
    func updateDistanceFromUserLocation() {
        guard let userLocation = userLocation else { return }
        defaultSalonDetails = defaultSalonDetails.map({ salonDetails in
            var salonDetails = salonDetails
            if let latitude = salonDetails.latitude,
               let longitude = salonDetails.longitude {
                let location = CLLocation(latitude: latitude, longitude: longitude)
                let distance = location.distance(from: userLocation)
                let distanceInKm = distance / 1000
                salonDetails.distance = distanceInKm
            }
            return salonDetails
        })
    }
    
    func filteredUserForShortestDistance()  {
        salonDetails = defaultSalonDetails.sorted(by: { salonDetails1, salonDetails2 in
            if let distance1 = salonDetails1.distance,
               let distance2 =  salonDetails2.distance {
                return distance1 < distance2
            }
            return true
        })
    }
    
    func filteredUserForShortestWaitTime()  {
        salonDetails = defaultSalonDetails.sorted(by: { salonDetails1, salonDetails2 in
            if let waitTime1 = salonDetails1.waitTime,
               let waitTime2 =  salonDetails2.waitTime {
                return waitTime1 < waitTime2
            }
            return true
        })
    }
}
