//
//  TypeSection.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 27/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

enum Type: String {
    case Tesouro = "Tesouro Direto"
    case Acoes = "Ações"
    case Fundos = "Fundos"
}

struct WalletViewModelTypeItem: WalletViewModelItem {
    
    var type: WalletViewModelItemType {
        return .type
    }

    let total: String
    let name: String
    var itemType: Type
    
    init(total: Double, type: Type) {
        self.total = Formatter.currencyFormatter.string(from: NSNumber(value: total)) ?? "R$ \(total)"
        self.name = type.rawValue.uppercased()
        self.itemType = type
    }

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        return NSCollectionLayoutSection(group: group)
    }
}
