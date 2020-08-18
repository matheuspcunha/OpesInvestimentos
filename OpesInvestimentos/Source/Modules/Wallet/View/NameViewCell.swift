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
    
    func configure(with viewModel: WalletViewModelNameItem) {
        labelName.text = viewModel.name
    }
}
