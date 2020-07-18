//
//  StatementTableViewController.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class StatementTableViewController: UITableViewController {

    lazy var viewModel = StatementViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.statementLoaded = statementLoaded
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Extrato"
        self.loadStatement()
    }

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
    
    private func statementLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func loadStatement(){
        viewModel.loadStatement()
    }
}

extension StatementTableViewController: StatementViewModelDelegate {
    func onLoadStatement(error: FirebaseError?) {
        DispatchQueue.main.async {
            if let error = error {
                Alert.show(title: error.title, message: error.message, presenter: self)
            }
        }
    }
}
