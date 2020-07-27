//
//  StatementTableViewCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class StatementTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    // MARK: - Methods
    
    func configure(with viewModel: StatementCellViewModel) {
        labelCode.text = viewModel.code
        labelDate.text = viewModel.date
        labelPrice.text = viewModel.price
        labelQuantity.text = viewModel.unityPrice
        labelType.text = viewModel.operationType
    }
}
