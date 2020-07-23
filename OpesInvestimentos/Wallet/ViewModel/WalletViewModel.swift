//
//  WalletViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

class WalletViewModel {
    
    // MARK: - Properties

    private var wallet: [Wallet] = [] {
        didSet {
            walletLoaded?()
        }
    }

    var walletLoaded: (()->Void)?

    var count: Int { return wallet.count }
    
    // MARK: - Methods

    func loadWallet() {
    }
}
