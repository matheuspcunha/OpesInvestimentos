//
//  PriceChartCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct PriceChartCellBuilder: TableViewCellBuilder {
    
    let prices: [Price]
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(PriceChartCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: PriceChartCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(prices: prices)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        false
    }
}
