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
}

class FirebaseService {
    
    // MARK: - Properties
    private static var auth = Auth.auth()

    private static var firestoreListener: ListenerRegistration!

    private static let firestore: Firestore = {
        return Firestore.firestore()
    }()
    
    // MARK: - Methods
    private init() {}

    static func register(email: String, password: String,
                         onComplete: @escaping (Result<Bool, Error>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                onComplete(.failure(error))
            } else {
                onComplete(.success(true))
            }
        }
    }
    
    static func login(withEmail email: String, password: String,
                      onComplete: @escaping (Result<Bool, Error>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                onComplete(.failure(error))
            } else {
                onComplete(.success(true))
            }
        }
    }
    
    // TODO: - Implementar closure aqui!
    static func AddToCollection(collection: DBCollection, id: String, data: [String : Any]) {
        self.firestore.collection(collection.rawValue).document(id).setData(data)
    }
    
    private static func getDocument(collection: DBCollection) {
        guard let userID = self.currentUser?.uid else {return}
        
        firestoreListener = firestore
                            .collection(collection.rawValue)
                            .whereField("id", isEqualTo: userID)
                            .addSnapshotListener(includeMetadataChanges: true, listener: { (snapshot, error) in
                                
                                if error != nil {
                                    print(error!)
                                    return
                                }
                                
                                guard let snapshot = snapshot else {return}
                                if snapshot.metadata.isFromCache || snapshot.documents.count > 0 {
                                    self.showUsers(snapshot: snapshot)
                                }
                            })
    }
    
    private static func showUsers(snapshot: QuerySnapshot) {
        for documents in snapshot.documents{
            let data = documents.data()
            let userID = (data["userID"] as? String) ?? ""
            let cpf = (data["CPF"] as? String) ?? ""
            print("ID: \(userID) - CPF: \(cpf)")
            break
        }
    }
    
    static var currentUser: Firebase.User? {
        return self.auth.currentUser
    }
    
    static func signOut() {
        try? auth.signOut()
    }
}
