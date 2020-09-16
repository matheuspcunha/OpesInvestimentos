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
        didSet {
            self.tableView.reloadData()
        }
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
        let tableView = UITableView.standard()
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

extension StatementView: StatementViewModelDelegate {
    func onLoadStatement() {
        DispatchQueue.main.async {
            if let data = self.viewModel.viewData {
                self.dataSource = TableViewDataSource(
                    sections: StatementTableViewFactory(viewData: data).make(),
                    tableView: self.tableView
                )
            }
        }
    }
}
