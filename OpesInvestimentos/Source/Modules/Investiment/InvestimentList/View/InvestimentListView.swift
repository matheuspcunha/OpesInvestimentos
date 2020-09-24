//
//  InvestimentListView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentListView: UIView {

    private var viewModel: InvestimentListViewModelProtocol!
    private var dataSource: TableViewDataSource?

    init(viewModel: InvestimentListViewModelProtocol) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.standard()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        self.dataSource = TableViewDataSource(
            sections: InvestimentListTableViewFactory(investiment: self.viewModel.investiment).make(),
            tableView: tableView
        )

        return tableView
    }()
}

extension InvestimentListView: InvestimentListViewProtocol {}

extension InvestimentListView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .appBackground
    }
    
    func setupHierarchy() {
        addSubviewWithConstraints(subview: tableView)
    }
}
