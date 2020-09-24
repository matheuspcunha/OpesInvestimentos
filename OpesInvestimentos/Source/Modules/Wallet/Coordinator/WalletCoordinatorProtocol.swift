//
//  WalletCoordinatorProtocol.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 24/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

protocol WalletCoordinatorProtocol: class, ScreenLoader {
    func showInvestimentList(for investiment: Investiment)
}
