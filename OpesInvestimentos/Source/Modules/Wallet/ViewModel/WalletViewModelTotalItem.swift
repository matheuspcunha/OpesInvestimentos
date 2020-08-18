//
//  TotalSection.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 25/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct WalletViewModelTotalItem: WalletViewModelItem {
    
    var type: WalletViewModelItemType {
        return .total
    }
    
    let total: String

    init(total: Double) {
        self.total = Formatter.currencyFormatter.string(from: NSNumber(value: total)) ?? "R$ \(total)"
    }

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        return NSCollectionLayoutSection(group: group)
    }
}
