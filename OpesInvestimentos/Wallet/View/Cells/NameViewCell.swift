//
//  NameViewCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 25/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class NameViewCell: UICollectionViewCell {

    @IBOutlet weak var labelName: UILabel!
    
    var name: String? {
        didSet {
            labelName.text = "Olá, \(name ?? "")! 🤑"
        }
    }
}
