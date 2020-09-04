//
//  WalletView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 23/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class WalletView: UIView {

    private var viewModel: WalletViewModelProtocol!
    private var dataSource: TableViewDataSource?
    
    init(viewModel: WalletViewModelProtocol) {
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
        
        dataSource = TableViewDataSource(
            sections: WalletTableViewFactory(viewData: self.viewModel.loadWallet()).make(),
            tableView: tableView
        )
        
        return tableView
    }()
}

extension WalletView: WalletViewProtocol{}

extension WalletView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .white
    }
    
    func setupHierarchy() {
        addSubviewWithConstraints(subview: tableView)
    }
    
    func setupConstraints() {}
}
