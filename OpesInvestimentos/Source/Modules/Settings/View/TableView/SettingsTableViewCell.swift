//
//  SettingsTableViewCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 27/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class SettingsTableViewCell<ViewModel: RawRepresentable>: LabelCell, CellConfigurable

    where ViewModel.RawValue == String {
    typealias ViewModel = ViewModel

    func configure(with model: ViewModel) {
        let setting = Settings.init(rawValue: model.rawValue)
        textLabel?.text = setting?.title
        textLabel?.textColor = setting?.color
        self.accessoryType = .disclosureIndicator
    }
}
