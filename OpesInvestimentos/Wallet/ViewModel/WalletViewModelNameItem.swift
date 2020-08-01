//
//  NameSection.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 25/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct WalletViewModelNameItem: WalletViewModelItem {
    
    var type: WalletViewModelItemType {
        return .name
    }
    
    let name: String

    init(name: String) {
        self.name = "Olá, \(name )! 🤑"
    }

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        return NSCollectionLayoutSection(group: group)
    }
}
