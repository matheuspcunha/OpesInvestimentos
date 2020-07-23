//
//  User.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

class User {
    
    // MARK: - Properties

    private let uid: String
    var name: String
    let cpf: String
    let email: String

    // MARK: - Methods

    init(id: String, name: String, cpf: String, email: String) {
        self.uid = id
        self.name = name
        self.cpf = cpf
        self.email = email
    }
    
    init(data: [String: Any]) {
        self.uid = (data["id"] as? String) ?? ""
        self.name = (data["name"] as? String) ?? ""
        self.cpf = (data["cpf"] as? String) ?? ""
        self.email = (data["email"] as? String) ?? ""
    }
    
    func toData() -> [String: Any] {
        let data: [String: Any] = [
            "id": self.uid,
            "cpf": self.cpf,
            "name": self.name,
            "email": self.email
        ]
        
        return data
    }
    
    var id: String {
        return self.uid
    }
}
