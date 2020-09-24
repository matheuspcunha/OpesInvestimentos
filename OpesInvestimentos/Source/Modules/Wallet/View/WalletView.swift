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
    
    private var dataSource: TableViewDataSource? {
        didSet {
            self.tableView.reloadData()
        }
    }

    init(viewModel: WalletViewModelProtocol) {
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
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
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
}

extension WalletView: WalletViewModelDelegate {
    func onLoadWallet() {
        DispatchQueue.main.async {
            if let data = self.viewModel.viewData {
                self.dataSource = TableViewDataSource(
                    sections: WalletTableViewFactory(viewData: data) { [weak self] type in
                        self?.viewModel.showDetail(for: type)
                    }.make(),
                    tableView: self.tableView
                )
            }
        }
    }
}
