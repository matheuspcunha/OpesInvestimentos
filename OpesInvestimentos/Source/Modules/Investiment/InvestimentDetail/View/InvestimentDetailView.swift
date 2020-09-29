//
//  InvestimentDetailView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentDetailView: UIView {

    private var viewModel: InvestimentDetailViewModelProtocol!
    private var dataSource: TableViewDataSource? {
        didSet { self.tableView.reloadData() }
    }

    init(viewModel: InvestimentDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.standard()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
}

extension InvestimentDetailView: InvestimentDetailViewProtocol {}

extension InvestimentDetailView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .white
    }
    
    func setupHierarchy() {
        addSubviewWithConstraints(subview: tableView)
    }
}

extension InvestimentDetailView: InvestimentDetailViewModelDelegate {

    func onLoadDetail() {
        guard let data = self.viewModel.viewData else { return }

        DispatchQueue.main.async {
            self.dataSource = TableViewDataSource(
                sections: InvestimentDetailTableViewFactory(data: data).make(),
                tableView: self.tableView
            )
        }
    }
}
