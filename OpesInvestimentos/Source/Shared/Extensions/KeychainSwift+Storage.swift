//
//  KeychainSwift+Storage.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 25/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import KeychainSwift

extension KeychainSwift {

    func get(_ key: KeychainKeys) -> String? {
        return get(key.rawValue)
    }
    
    func set(_ value: String, forKey key: KeychainKeys) {
        set(value, forKey: key.rawValue)
    }
}
