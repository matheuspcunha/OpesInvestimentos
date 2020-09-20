//
//  DetailCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 19/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct DetailCellBuilder: TableViewCellBuilder {
    
    let totalCost: Double
    let result: Double
    let variation: Double

    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(DetailCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: DetailCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(totalCost: totalCost, result: result, variation: variation)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        false
    }
}
