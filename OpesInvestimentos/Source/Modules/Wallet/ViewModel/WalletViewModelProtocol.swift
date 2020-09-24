//
//  WalletViewModelProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 23/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

protocol WalletViewModelProtocol: class {
    var view: WalletViewProtocol? { get set }
    var delegate: WalletViewModelDelegate? { get set }
    var viewData: WalletViewDataProtocol? { get set }
    
    func loadWallet()
    func showDetail(for investiment: Investiment)
}

protocol WalletViewModelDelegate: class {
    func onLoadWallet()
}
