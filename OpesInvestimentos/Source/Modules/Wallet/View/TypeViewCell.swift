//
//  TypeViewCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 27/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class TypeViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    func configure(with viewModel: WalletViewModelTypeItem) {
        totalLabel.text = viewModel.total
        totalLabel.textColor = getColor(viewModel.itemType)
        nameLabel.text = viewModel.name
    }
    
    private func getColor(_ type: Type) -> UIColor {
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
