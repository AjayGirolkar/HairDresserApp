//
//  AuthenticationViewModel.swift
//  HairDresser
//
//  Created by Rajesh Kanneboyena on 06/03/23.
//


import SwiftUI
import Firebase
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthenticationViewModel()
    
    init() {
        self.user = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Login failed: \(error.localizedDescription)")
                completion(false, error.localizedDescription)
            }
            guard let user = result?.user else { return }
            print("\n\n DEBUG: Login successfully \n")
            self.user = user
            completion(true, nil)
            self.fetchUser()
        }
    }
    
    func register(email: String, password: String,
                  image: UIImage, fullname: String,
                  username: String, userRole: String,
                  completion: @escaping (Bool, String?) -> Void) {
        
        ImageUploader.uploadImage(uiImage: image, type: .profile) { imageURL in
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
                            "userRole": userRole.lowercased(),
                            "uid": user.uid]
                
                self.saveCollectionData(collectionName: "users", documentID: user.uid,
                                        data: data, user: user, completion: completion)
            }
        }
    }
    
    func saveCollectionData(collectionName: String, documentID: String,
                            data: [String: Any], user: FirebaseAuth.User,
                            completion: @escaping (Bool, String?) -> Void) {
        Firestore.firestore().collection(collectionName).document(documentID).setData(data) { error in
            if let error {
                print("Error in collection saving : \(error.localizedDescription)")
                completion(false, error.localizedDescription)
            }
            self.user = user
            completion(true, nil)
            print("Successfully uploaded userdata")
        }
    }
    
    func signout() {
        self.user = nil
        self.currentUser = nil
        try? Auth.auth().signOut()
        print("signout")
    }
    
    func resetpassword() {
        
    }
    
    func fetchUser() {
        guard let userID = self.user?.uid else { return }
        Constants.COLLECTION_USERS.document(userID).getDocument { snapshot, error in
            if let error {
                print( "Error in fetching user \(error.localizedDescription)")
            }
            //Success
            if let user = try? snapshot?.data(as: User.self) {
                self.currentUser = user
            }
        }
    }
}


