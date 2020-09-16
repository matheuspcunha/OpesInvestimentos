//
//  StatementCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 07/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct StatementCellBuilder: TableViewCellBuilder {
    
    var model: Statement
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(StatementCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: StatementCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(viewModel: StatementCellViewModel(statement: model))
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        true
    }

    func tableViewDidSelectCell(_ tableView: UITableView) {
        print("did select cell")
    }
}
