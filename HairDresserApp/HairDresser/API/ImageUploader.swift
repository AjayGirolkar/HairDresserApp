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
    
    static func uploadImages(user: User, type: UploadType, images: [UIImage]) async throws -> [String]  {
            // your path
        let id = user.id ?? UUID().uuidString
        let storageRef = type.filePath.child("salon_images")
            
            return try await withThrowingTaskGroup(of: String.self) { group in
                
                // the urlStrings you are eventually returning
                var urlStrings = [String]()
                
                // just using index for testing purposes so each image doesnt rewrites itself
                // of course you can also use a hash or a custom id instead of the index
                
                // looping over each image data and the index
                for (index, image) in images.enumerated() {
                    
                    // adding the method of storing our image and retriving the urlString to the task group
                    group.addTask(priority: .background) {
                        if let imageData = image.jpegData(compressionQuality: 0.5) {
                            let _ = try await storageRef.child("\(index)").putDataAsync(imageData)
                            return try await storageRef.child("\(index)").downloadURL().absoluteString
                        }
                        return ""
                    }
                }
                
                for try await uploadedPhotoString in group {
                    // for each task in the group, add the newly uploaded urlSting to our array...
                    urlStrings.append(uploadedPhotoString)
                }
                // ... and lastly returning it
                return urlStrings
            }
        }
}


class AsyncCaller {
    static func getImageFromURL(imageUrls: [String]) async throws -> [UIImage]? {
        var images: [UIImage] = []
        
        for urlString in imageUrls {
            if let url = URL(string: urlString) {
                do {
                    let (data, response) =  try await URLSession.shared.data(from: url)
                    if let image = handleResponse(data: data, response: response) {
                        images.append(image)
                    }
                } catch {
                    throw error
                }
            }
        }
        return images
    }
    
    static func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
}
