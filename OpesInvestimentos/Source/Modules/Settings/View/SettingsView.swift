//
//  SettingsView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 11/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class SettingsView: UIView {

    private var viewModel: SettingsViewModelProtocol!
    private var dataSource: TableViewDataSource?
    
    init(viewModel: SettingsViewModelProtocol) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.standard()
        
        let factory = SettingsTableViewFactory { [weak self] type in
            self?.viewModel.showSetting(for: type)
        }
        
        self.dataSource = TableViewDataSource(
            sections: factory.make(),
            tableView: tableView
        )
        
        return tableView
    }()
}

extension SettingsView: SettingsViewProtocol {}

extension SettingsView: ViewCodeProtocol {
    
    func setupHierarchy() {
        addSubviewWithConstraints(subview: tableView)
    }
    
    func setupConstraints() {}
}
