//
//  AssetsChartCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 23/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct AssetsChartCellBuilder: TableViewCellBuilder {
    
    let assets: [InvestimentAsset]
    let total: Double
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(AssetsChartCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: AssetsChartCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(assets: assets, totalInvestiment: total)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        false
    }
}
