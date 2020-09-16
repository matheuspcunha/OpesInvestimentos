//
//  TotalCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 02/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct TotalCellBuilder: TableViewCellBuilder {
    
    var value: String
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(TotalCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: TotalCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(value: value)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        false
    }
}
