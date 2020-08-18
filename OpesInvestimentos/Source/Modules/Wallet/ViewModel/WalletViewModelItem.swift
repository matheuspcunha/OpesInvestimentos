//
//  Section.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 25/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

enum WalletViewModelItemType {
    case total
    case name
    case type
    case pie
}

protocol WalletViewModelItem {
    var numberOfItems: Int { get }
    var type: WalletViewModelItemType { get }
    func layoutSection() -> NSCollectionLayoutSection
}

extension WalletViewModelItem {
   var numberOfItems: Int {
      return 1
   }
}
