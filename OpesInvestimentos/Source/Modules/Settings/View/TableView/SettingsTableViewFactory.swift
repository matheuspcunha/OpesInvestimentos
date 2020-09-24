//
//  SettingsTableViewFactory.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct SettingsTableViewFactory {

    typealias ExampleViewModel = Settings
    typealias SelectedExample = (ExampleViewModel) -> Void

    var didSelect: SelectedExample

    func make() -> [TableViewSection] {
        let section = StaticSection(
            cellBuilders: cellBuilders(),
            footer: UIView()
        )
        return [section]
    }

    func cellBuilders() -> [TableViewCellBuilder] {
        return ExampleViewModel.allCases.map { type in
            SelectableCellBuilder<SettingsTableViewCell<ExampleViewModel>>(
                model: type, didSelect: didSelect
            )
        }
    }
}
