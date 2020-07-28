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
    
    func configure(name: String, total: String, color: UIColor) {
        totalLabel.text = total
        totalLabel.textColor = color
        nameLabel.text = name
    }
}
