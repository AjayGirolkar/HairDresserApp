//
//  AuthenticationViewModel.swift
//  HairDresserApp
//
//  Created by Lakshmi Sowjanya on 07/03/23.
//

import Foundation
import UIKit
import Firebase

class AuthenticationViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User?
    
    static let shared = AuthenticationViewModel()
    
    init() {
        self.user = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("DEBUG: Login failed: \(error.localizedDescription)")
            }
            guard let user = result?.user else { return }
            print("\n\n DEBUG: Login successfully \n")
            self.user = user
        }
    }
    
    func register(email: String, password: String,
                  image: UIImage, fullname: String,
                  username: String, userRole: String) {
        
        ImageUploader.uploadImage(uiImage: image) { imageURL in
            guard let imageURL else {
                return
            }
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let user = result?.user else { return }
                self.user = user
                print("Successfully created user: \(user)")
                
                let data = ["email": email,
                            "username": username,
                            "fullname": fullname,
                            "profileImageUrl": imageURL,
                            "uid": user.uid,
                            "userRole": userRole]
                
                self.saveCollectionData(collectionName: "users", documentID: user.uid, data: data, user: user)
            }
        }
    }
    
    func saveCollectionData(collectionName: String, documentID: String, data: [String: Any], user: User) {
        Firestore.firestore().collection(collectionName).document(documentID).setData(data) { error in
            if let error {
                print("Error in collection saving : \(error.localizedDescription)")
                return
            }
            self.user = user
            print("Successfully uploaded userdata")
        }
    }
    
    func signout() {
        self.user = nil
        try? Auth.auth().signOut()
        print("signout")
    }
    
    func resetpassword() {
        
    }
    
    func fetchUser() {
        guard let userID = self.user?.uid else { return }
        Firestore.firestore().collection("users").document(userID).getDocument { snapshot, error in
            if let error {
                print( "Error in fetching user \(error.localizedDescription)")
            }
            //Success
            if let data = snapshot?.data() {
                print( "Success: got user data : \(data.debugDescription)")
            }
        }
    }
}


