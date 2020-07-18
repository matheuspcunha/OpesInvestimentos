//
//  FirebaseService.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import Firebase

enum DBCollection: String {
    case userInfo = "UserInfo"
    case statement = "Statement"
}

class FirebaseService {
    
    // MARK: - Properties
    
    private static var auth = Auth.auth()

    private static var firestoreListener: ListenerRegistration!

    private static let db: Firestore = {
        return Firestore.firestore()
    }()
    
    // MARK: - Methods
    
    private init() {}

    static func register(email: String, password: String,
                         onComplete: @escaping (Result<Bool, FirebaseError>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    onComplete(.failure(errorCode.error))
                }
            } else {
                onComplete(.success(true))
            }
        }
    }
    
    static func login(withEmail email: String, password: String,
                      onComplete: @escaping (Result<Bool, FirebaseError>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    onComplete(.failure(errorCode.error))
                }
            } else {
                onComplete(.success(true))
            }
        }
    }
    
    static func addUser(id: String, data: [String : Any],
                        onComplete: @escaping (Result<Bool, FirebaseError>) -> Void) {
        
        self.db.collection(DBCollection.userInfo.rawValue).document(id).setData(data) { (error) in
            if let error = error as NSError? {
                if let errorCode = FirestoreErrorCode(rawValue: error.code) {
                    onComplete(.failure(errorCode.error))
                }
            } else {
                onComplete(.success(true))
            }
        }
    }
    
    static func setToSubCollection(in collection: DBCollection, set data: [String : Any]) {
        guard let userID = self.currentUser?.uid else {return}

        self.db.collection(DBCollection.userInfo.rawValue).document(userID)
            .collection(collection.rawValue).addDocument(data: data)
    }
    
    static func getDocument(collection: DBCollection,
                            onComplete: @escaping (QuerySnapshot?, FirebaseError?) -> Void) {
        
        guard let userID = self.currentUser?.uid else {return}
        let docRef = db.collection(DBCollection.userInfo.rawValue).whereField("id", isEqualTo: userID)
        
        firestoreListener = docRef.addSnapshotListener(includeMetadataChanges: true, listener: { (snapshot, error) in
                                
                                if let error = error as NSError? {
                                    if let errorCode = FirestoreErrorCode(rawValue: error.code) {
                                        onComplete(nil, errorCode.error)
                                    }
                                }
                                
                                guard let snapshot = snapshot else {return}
                                if snapshot.metadata.isFromCache || snapshot.documents.count > 0 {
                                    onComplete(snapshot, nil)
                                }
                            })
    }
    
    static func getSubDocument(collection: DBCollection,
                               onComplete: @escaping (QuerySnapshot?, FirebaseError?) -> Void) {
        
        guard let userID = self.currentUser?.uid else {return}
        let docRef = db.collection(DBCollection.userInfo.rawValue).document(userID).collection(collection.rawValue)
        
        firestoreListener = docRef.addSnapshotListener(includeMetadataChanges: true, listener: { (snapshot, error) in
                                
                                if let error = error as NSError? {
                                    if let errorCode = FirestoreErrorCode(rawValue: error.code) {
                                        onComplete(nil, errorCode.error)
                                    }
                                }
                                
                                guard let snapshot = snapshot else {return}
                                if snapshot.metadata.isFromCache || snapshot.documents.count > 0 {
                                    onComplete(snapshot, nil)
                                }
                            })
    }
    
    static func updateUserName(name: String) {
        guard let user = currentUser else {return}
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.commitChanges { (error) in
            print(error ?? "")
        }
        
    }
    
    static var currentUser: Firebase.User? {
        return self.auth.currentUser
    }
    
    static func signOut() {
        try? auth.signOut()
    }
}

extension AuthErrorCode {
    var error: FirebaseError {
        switch self {
        case .emailAlreadyInUse:
            return .emailAlreadyInUse
        case .userDisabled:
            return .userDisabled
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return .invalidEmail
        case .networkError:
            return .networkError
        case .weakPassword:
            return .weakPassword
        default:
            return .unknown
        }
    }
}

extension FirestoreErrorCode {
    var error: FirebaseError {
        switch self {
        case .alreadyExists:
            return .unknown
        case .notFound:
            return .unknown
        case .cancelled:
            return .unknown
        case .unavailable:
            return .unknown
        default:
            return .unknown
        }
    }
}

