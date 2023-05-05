//
//  APIManager.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 06/03/23.
//

import UIKit
import Firebase

class FirebaseManager {
    
    @Published var user: FirebaseAuth.User?
    
    static let shared = AuthenticationViewModel()
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    static func uploadImage(uiImage: UIImage, type: UploadType, completion: @escaping (String?) -> Void) {
        
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return completion(nil) }
        let ref = type.filePath
        
        ref.putData(imageData) { _, error in
            if let error = error {
                print("DEBUG: failed to upload data \(error.localizedDescription)")
                return completion(nil)
            }
            print("Successfully uploaded image")
            
            ref.downloadURL { url, _ in
                guard let imageURL = url?.absoluteString else { return completion(nil) }
                completion(imageURL)
            }
        }
    }
    
    static func register(isUpdate: Bool = false,
                         salonDetails: SalonDetails,
                         images: [UIImage],
                         selectedServices: [[String: [String]]],
                         completion: @escaping (Bool, String?) -> Void) async {
        guard let user = AuthenticationViewModel.shared.currentUser else {
            return completion(false, nil)
        }
        guard let imagesURLS =  try? await ImageUploader.uploadImages(user: user, type: .salon, images: images) else {
            return completion(false, nil)
        }
        let documentID = salonDetails.id ?? UUID().uuidString
        let list: [String : Any] = ["id": documentID,
                                    "uid": user.id ?? "",
                                    "salonName": salonDetails.salonName,
                                    "ownerName": salonDetails.ownerName,
                                    "contactNumber": salonDetails.contactNumber,
                                    "address": salonDetails.address,
                                    "imageURLs": imagesURLS,
                                    "email": salonDetails.email,
                                    "openTime": salonDetails.openTime ?? "",
                                    "closeTime": salonDetails.closeTime ?? "",
                                    "waitTime": salonDetails.waitTime ?? "",
                                    "latitude": salonDetails.latitude ?? "",
                                    "longitude": salonDetails.longitude ?? "",
                                    "serviceList": selectedServices]
        let data: [String : Any] = ["salonDetails": list]
        if isUpdate {
            self.updateSalonData(documentID: documentID, collectionName: "SalonDetails", data: data, completion: completion)
        } else {
            self.saveSalonData(documentID: documentID, collectionName: "SalonDetails", data: data, completion: completion)
        }
        
    }
    
    static func updateSalonData(documentID: String,
                          collectionName: String, data: [String: Any],
                          completion: @escaping (Bool, String?) -> Void) {
        Firestore.firestore().collection(collectionName).document(documentID).updateData(data) { error in
            if let error {
                print("Error in collection saving : \(error.localizedDescription)")
                completion(false, error.localizedDescription)
                return
            }
            completion(true, nil)
            print("Successfully uploaded userdata")
        }
    }
    
    static func saveSalonData(documentID: String,
                              collectionName: String, data: [String: Any],
                              completion: @escaping (Bool, String?) -> Void) {
       
        Firestore.firestore().collection(collectionName).document(documentID).setData(data) { error in
            if let error {
                print("Error in collection saving : \(error.localizedDescription)")
                completion(false, error.localizedDescription)
                return
            }
            completion(true, nil)
            print("Successfully uploaded userdata")
        }
    }
    
    static func getSalonDetails(userId: String, completion: @escaping (Bool, String?, SalonDetailModel?) -> Void) {
        APIConstants.collection_salonDetails.document(userId).getDocument { snapshot, error in
            if let error {
                print( "Error in fetching user \(error.localizedDescription)")
                return  completion(false, error.localizedDescription, nil)
            } else {
                do {
                    if let salonDetailModel = try snapshot?.data(as: SalonDetailModel.self) {
                        print(salonDetailModel.salonDetails)
                        completion(true, nil, salonDetailModel)
                        return
                    }
                } catch (let error ) {
                    print(error)
                    completion(false, error.localizedDescription, nil)
                }
            }
            completion(false, nil, nil)
        }
    }
    
    static func getAllSalonList(completion: @escaping (Bool, String?, [SalonDetailModel]?) -> Void) {
        guard let currentUser = AuthenticationViewModel.shared.currentUser,
              let userID = currentUser.id else { return }
        APIConstants.collection_salonDetails.getDocuments{ snapshot, error in
            if let error {
                print( "Error in fetching user \(error.localizedDescription)")
                return  completion(false, error.localizedDescription, nil)
            } else {
                guard let documents = snapshot?.documents else {
                    completion(false, nil, nil)
                    return }
                let salonDetailModels = documents.compactMap({ try? $0.data(as: SalonDetailModel.self) })
                completion(true, nil, salonDetailModels)
                print(salonDetailModels)
            }
        }
    }
    
    static func submit(submitScreenModel: SubmitScreenModel,
                       completion: @escaping (Bool, String?) -> Void) {
        guard let user = AuthenticationViewModel.shared.currentUser,
              let id = user.id else {
            return completion(false, nil)
        }
        let data: [String: Any] = getDataFromSubmitModel(submitScreenModel: submitScreenModel)
        APIConstants.collection_appointmentDetails.document(id).setData(data){ error in
            if let error {
                print( "Error in fetching user \(error.localizedDescription)")
                return  completion(false, error.localizedDescription)
                completion(false, nil)
            }
            completion(true, nil)
        }
    }
    
    static func getDataFromSubmitModel(submitScreenModel: SubmitScreenModel) -> [String: Any] {
        var  data: [String: Any] = [:]
        data["salonUID"] = submitScreenModel.salonDetails.uid
        data["salonName"] = submitScreenModel.salonDetails.salonName
        data["formattedDate"] = submitScreenModel.userSelectionModel?.dateSelectedItem?.value()
        data["appointmentDate"] = submitScreenModel.userSelectionModel?.dateSelectedItem?.date?.toString() ?? ""
        data["time"] = submitScreenModel.userSelectionModel?.checkInTimeSelectionModel?.value() ?? ""
        data["stylisherName"] = submitScreenModel.userSelectionModel?.stylishSelectedItem?.value()
        let selectedServiceList = submitScreenModel.selectedServiceList.map { selectedServiceInput in
            let serviceNames = selectedServiceInput.serviceList
            return [selectedServiceInput.categoryName : serviceNames]
        }
        data["selectedServiceList"] = selectedServiceList
        return data
    }
}
