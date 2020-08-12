//
//  Defaults.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 22/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class Defaults {
    
    // MARK: - Properties
    
    static let shared = Defaults()
    
    private let LAST_UPDATE_WALLET: String = "last_update_wallet"
    private let LAST_UPDATE_HISTORY: String = "last_update_history"
    private let LAST_UPDATE_DIVIDEND: String = "last_update_dividend"
    private let CPF: String = "user_cpf"
    private let APP_STATUS: String = "app_status"

    // MARK: - Methods
    
    var lastUpdateWallet: Date? {
        get {
            return UserDefaults.standard.object(forKey: LAST_UPDATE_WALLET) as? Date
        }
        set(date) {
            UserDefaults.standard.set(date, forKey: LAST_UPDATE_WALLET)
        }
    }
    
    var lastUpdateHistory: Date? {
        get {
            return UserDefaults.standard.object(forKey: LAST_UPDATE_HISTORY) as? Date
        }
        set(date) {
            UserDefaults.standard.set(date, forKey: LAST_UPDATE_HISTORY)
        }
    }
    
    var lastUpdateDividend: Date? {
        get {
            return UserDefaults.standard.object(forKey: LAST_UPDATE_DIVIDEND) as? Date
        }
        set(date) {
            UserDefaults.standard.set(date, forKey: LAST_UPDATE_DIVIDEND)
        }
    }
    
    var cpf: String? {
        get {
            return UserDefaults.standard.object(forKey: CPF) as? String
        }
        set(cpf) {
            UserDefaults.standard.set(cpf, forKey: CPF)
        }
    }
    
    var appStatus: Int? {
        get {
            return UserDefaults.standard.object(forKey: APP_STATUS) as? Int
        }
        set(status) {
            UserDefaults.standard.set(status, forKey: APP_STATUS)
        }
    }
    
    private init() {}
}
