//
//  StatementView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 07/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class StatementView: UIView {

    private var viewModel: StatementViewModelProtocol!
    private var dataSource: TableViewDataSource?
    
    init(viewModel: StatementViewModelProtocol) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.standard()

        dataSource = TableViewDataSource(
            sections: StatementTableViewFactory(viewData: self.viewModel.loadStatement()).make(),
            tableView: tableView
        )

        return tableView
    }()
}

extension StatementView: StatementViewProtocol {}

extension StatementView: ViewCodeProtocol {
    
    func setupHierarchy() {
        addSubviewWithConstraints(subview: tableView)
    }
    
    func setupConstraints() {}
}
