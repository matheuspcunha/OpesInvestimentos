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
    case stockHistory = "StockHistory"
    case dividends = "Dividends"
    case wallet = "Wallet"
}

class FirebaseService {
    
    // MARK: - Properties
    
    private static var auth = Auth.auth()

    private static var firestoreListener: ListenerRegistration!

    private static let firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()
    
    private static let db: DocumentReference = {
        return firestore.collection(DBCollection.userInfo.rawValue).document(userID)
    }()
    
    private static let userID: String = {
        return currentUser!.uid
    }()
    
    static var currentUser: Firebase.User? {
        return self.auth.currentUser
    }
    
    // MARK: - Methods
    
    private init() {}

    static func register(email: String, withPassword password: String,
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
    
    static func setUserInfo(data: [String : Any]) {
        self.db.setData(data)
    }
    
    static func getUserInfo(onComplete: @escaping (User?, FirebaseError?) -> Void) {
        
        db.getDocument(source: .server) { (doc, error) in
            if let error = error as NSError? {
                if let errorCode = FirestoreErrorCode(rawValue: error.code) {
                    onComplete(nil, errorCode.error)
                }
            }
            
            if let doc = doc, doc.exists, let userData = doc.data() {
                onComplete(User(data: userData), nil)
            } else {
                onComplete(nil, FirebaseError.unknown)
            }
        }
    }
    
    static func setSubCollection(in collection: DBCollection, set data: [String : Any]) {
        self.db.collection(collection.rawValue).addDocument(data: data)
    }
    
    static func getSubCollection(collection: DBCollection,
                                 onComplete: @escaping (QuerySnapshot?, FirebaseError?) -> Void) {
        
        let docRef = db.collection(collection.rawValue)
        
        firestoreListener = docRef.addSnapshotListener(includeMetadataChanges: false, listener: { (snapshot, error) in
                                
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
    
    static func checkIfExist(collection: DBCollection, onCompletion: @escaping (Bool) -> ()) {
        let docRef = db.collection(collection.rawValue)

        firestoreListener = docRef.addSnapshotListener(includeMetadataChanges: true, listener: { (snapshot, error) in
                                if error != nil {
                                    onCompletion(false)
                                }
                                
                                guard let snapshot = snapshot else {return}
                                if snapshot.metadata.isFromCache || snapshot.documents.count > 0 {
                                    onCompletion(true)
                                } else {
                                    onCompletion(false)
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

