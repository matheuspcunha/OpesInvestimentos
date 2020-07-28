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

struct TypeSection: Section {
    let numberOfItems = 1
    
    private let total: String
    private let name: String
    private var color: UIColor = UIColor()

    init(total: Double, type: Type) {
        self.total = Formatter.currencyFormatter.string(from: NSNumber(value: total)) ?? "R$ \(total)"
        self.name = type.rawValue.uppercased()
        self.color = getTypeColor(type)
    }

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        return NSCollectionLayoutSection(group: group)
    }

    func configure(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TypeViewCell.self), for: indexPath) as! TypeViewCell
        cell.configure(name: name, total: total, color: color)
        return cell
    }
    
    private func getTypeColor(_ type: Type) -> UIColor {
        switch type {
        case .Tesouro:
            return UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0)
        case .Fundos:
            return UIColor(red: 230/255.0, green: 126/255.0, blue: 34/255.0, alpha: 1.0)
        default:
            return UIColor(red: 165/255.0, green: 94/255.0, blue: 234/255.0, alpha: 1.0)
        }
    }
}
