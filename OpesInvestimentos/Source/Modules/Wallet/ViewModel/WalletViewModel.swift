//
//  WalletViewModel.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

final class WalletViewModel: WalletViewModelProtocol {
    
    weak var view: WalletViewProtocol?
    private var coordinator: WalletCoordinatorProtocol?
    
    init(coordinator: WalletCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    private var wallet: [Wallet] = []
    
    weak var delegate: WalletViewModelDelegate?
    
    var walletLoaded: (()->Void)?
    
    // MARK: - Methods

    func loadWallet() -> WalletViewDataProtocol {
//        FirebaseService.getData(collection: .wallet) { (query, error) in
//            guard let query = query, error == nil else {
//                self.walletLoaded?()
//                return
//            }
//
//            var wallet: [Wallet] = []
//            for document in query.documents {
//                let data = document.data()
//                wallet.append(Wallet(dictionary: data))
//            }
//
//            let viewData = WalletViewData(wallet: CEIServiceAPI.testGetWallet()!)
//        }
        
        return WalletViewData(wallet: CEIServiceAPI.testGetWallet()!)
    }
}

