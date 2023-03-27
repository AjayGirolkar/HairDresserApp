//
//  ImageUploader.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 06/03/23.
//

import SwiftUI
import FirebaseStorage

enum UploadType {
    case profile
    case salon
    
    var filePath: StorageReference {
        let filename = UUID().uuidString
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_images/\(filename)")
        case .salon:
            return Storage.storage().reference(withPath: "/salon_images/\(filename)")
        }
    }
}

struct ImageUploader {
    
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
}


