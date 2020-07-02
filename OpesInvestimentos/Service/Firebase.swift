//
//  Firebase.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    private static var auth = Auth.auth()
    
    private var firestoreListener: ListenerRegistration!

    private static let firestore: Firestore = {
        let firestore = Firestore.firestore()
        return firestore
    }()
    
    private init() {}

    static func register(email: String, password: String,
                         onComplete: @escaping (Result<Bool, Error>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                onComplete(.failure(error))
            } else{
                onComplete(.success(true))
            }
        }
    }
    
    static func login(withEmail email: String, password: String,
                      onComplete: @escaping (Result<Bool, Error>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                onComplete(.failure(error))
            } else{
                onComplete(.success(true))
            }
        }
    }
    
    static func AddToCollection(collection: String, data: [String : Any]) {
        self.firestore.collection(collection).addDocument(data: data)
    }
}
