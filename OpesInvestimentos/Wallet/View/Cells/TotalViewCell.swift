//
//  TotalCollectionViewCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 25/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class TotalViewCell: UICollectionViewCell {

    @IBOutlet weak var totalLabel: UILabel!
    
    var total: String? {
        didSet {
            totalLabel.text = total
        }
    }
}
