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
    
    private static let LAST_UPDATE_WALLET: String = "last_update_wallet"
    private static let LAST_UPDATE_HISTORY: String = "last_update_history"
    private static let LAST_UPDATE_DIVIDEND: String = "last_update_dividend"
    
    // MARK: - Methods
    
    static var lastUpdateWallet: Date? {
        get {
            return UserDefaults.standard.object(forKey: LAST_UPDATE_WALLET) as? Date
        }
        set(date) {
            UserDefaults.standard.set(date, forKey: LAST_UPDATE_WALLET)
        }
    }
    
    static var lastUpdateHistory: Date? {
        get {
            return UserDefaults.standard.object(forKey: LAST_UPDATE_HISTORY) as? Date
        }
        set(date) {
            UserDefaults.standard.set(date, forKey: LAST_UPDATE_HISTORY)
        }
    }
    
    static var lastUpdateDividend: Date? {
        get {
            return UserDefaults.standard.object(forKey: LAST_UPDATE_DIVIDEND) as? Date
        }
        set(date) {
            UserDefaults.standard.set(date, forKey: LAST_UPDATE_DIVIDEND)
        }
    }
    
    private init() {}
}
