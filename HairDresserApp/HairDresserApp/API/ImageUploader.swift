//
//  ImageUploader.swift
//  HairDresserApp
//
//  Created by Ajay Girolkar on 07/03/23.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(uiImage: UIImage, completion: @escaping (String?) -> Void) {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return completion(nil) }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
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

