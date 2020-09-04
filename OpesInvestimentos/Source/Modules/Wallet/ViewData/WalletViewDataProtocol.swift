//
//  WalletViewDataProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

protocol WalletViewDataProtocol {
    var investiments: [Investiment] { get }
    var total: String { get }
    var name: String { get }
}
