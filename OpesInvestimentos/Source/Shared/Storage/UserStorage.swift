//
//  UserStorage.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 25/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import KeychainSwift

protocol UserStorage {
    var name: String? { get set }
    var cpf: String? { get set }
}

enum KeychainKeys: String {
    case userName = "UserName"
    case userCPF = "UserCPF"
}

extension KeychainSwift: UserStorage {
    var name: String? {
        get { return get(.userName) }
        set { set(newValue ?? "", forKey: .userName) }
    }
    
    var cpf: String? {
        get { return get(.userCPF) }
        set { set(newValue ?? "", forKey: .userCPF) }
    }
}
