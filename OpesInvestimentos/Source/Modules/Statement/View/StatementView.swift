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
    private var dataSource: TableViewDataSource? {
        didSet { self.tableView.reloadData() }
    }
    
    init(viewModel: StatementViewModelProtocol) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        self.viewModel.delegate = self
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        UITableView.standard()
    }()
}

extension StatementView: StatementViewProtocol {}

extension StatementView: ViewCodeProtocol {

    func setupHierarchy() {
        addSubviewWithConstraints(subview: tableView)
    }
}

extension StatementView: StatementViewModelDelegate {

    func onLoadStatement() {
        guard let data = self.viewModel.viewData else { return }

        DispatchQueue.main.async {
            self.dataSource = TableViewDataSource(
                sections: StatementTableViewFactory(viewData: data).make(),
                tableView: self.tableView
            )
        }
    }
}
