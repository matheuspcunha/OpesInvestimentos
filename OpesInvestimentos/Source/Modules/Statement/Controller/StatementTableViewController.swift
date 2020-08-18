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
    
    private lazy var viewModel = StatementViewModel()
    
    private let searchController = UISearchController(searchResultsController: nil)

    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureSearchController()
        self.refreshControl?.addTarget(self, action: #selector(loadStatement), for: UIControl.Event.valueChanged)

        viewModel.statementLoaded = statementLoaded
        viewModel.statementFiltered = statementFiltered

        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.setLoading()
        self.loadStatement()
    }

    private func statementLoaded() {
        DispatchQueue.main.async {
            if self.viewModel.count == 0 {
                self.tableView.setEmptyView(title: "Nenhuma Movimentação", message: "O extrato de seus investimentos aparecerá aqui.")
            } else {
                self.tableView.reloadData()
                self.tableView.restore()
            }
            
            self.refreshControl?.endRefreshing()
        }
    }
    
    private func statementFiltered() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func loadStatement(){
        viewModel.loadStatement()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar Ativo"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = Operation.allCases.filter({$0 != .Leilao}).map{ $0.rawValue}
        searchController.searchBar.delegate = self
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel.filteredCount
        }
        
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StatementTableViewCell
        cell.configure(with: viewModel.cellViewModelFor(indexPath: indexPath, filter: isFiltering))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(indexPath: indexPath, filter: isFiltering) { (result) in
                switch result {
                case .success:
                    break
                case .failure:
                    Alert.show(title: "Erro", message: "Não foi possível excluir", presenter: self)
                }
            }
        }
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

extension StatementTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let operation = Operation(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        viewModel.filterContentForSearchText(searchBar.text, operation: operation)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let operation = Operation(rawValue:
        searchBar.scopeButtonTitles![selectedScope])
        
        viewModel.filterContentForSearchText(searchBar.text, operation: operation)
    }
}
