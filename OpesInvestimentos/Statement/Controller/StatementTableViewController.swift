//
//  StatementTableViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class StatementTableViewController: UITableViewController {

    // MARK: - Properties
    
    lazy var viewModel = StatementViewModel()

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(loadStatement), for: UIControl.Event.valueChanged)

        viewModel.statementLoaded = statementLoaded
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Extrato"
        self.tableView.setLoading()
        self.loadStatement()
    }

    private func statementLoaded() {
        DispatchQueue.main.async {
            
            self.refreshControl?.endRefreshing()
            
            if self.viewModel.count == 0 {
                self.tableView.setEmptyView(title: "Nenhuma Movimentação", message: "O extrato de seus investimentos aparecerá aqui.")
            } else {
                self.tableView.reloadData()
                self.tableView.restore()
            }
        }
    }
    
    @objc private func loadStatement(){
        viewModel.loadStatement()
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StatementTableViewCell
        cell.configure(with: viewModel.cellViewModelFor(indexPath: indexPath))
        
        return cell
    }
}

extension StatementTableViewController: StatementViewModelDelegate {
    
    func onLoadStatement(error: FirebaseError?) {
        DispatchQueue.main.async {
            if let error = error {
                Alert.show(title: error.title, message: error.message, presenter: self)
                self.statementLoaded()
            }
        }
    }
}
