//
//  WalletViewModelPieItem.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation
import UIKit
import Charts

struct PieItem {
    let type: Type
    let value: Double
}

struct WalletViewModelPieItem: WalletViewModelItem {
    var type: WalletViewModelItemType {
        return .pie
    }

    var dataEntry = [PieChartDataEntry]()
    
    init(items: [PieItem]) {
        for item in items {
            dataEntry.append(PieChartDataEntry(value: item.value, label: item.type.rawValue))
        }
    }
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        return NSCollectionLayoutSection(group: group)
    }
}
