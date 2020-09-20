//
//  WalletViewDataProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

protocol WalletViewDataProtocol {
    var name: String { get }
    var investiments: [Investiment] { get }
    var total: Double { get }
    var totalCost: Double { get }
    var result: Double { get }
    var variation: Double { get }
}
