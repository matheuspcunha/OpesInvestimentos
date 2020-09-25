//
//  TotalAssetCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 24/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct TotalAssetCellBuilder: TableViewCellBuilder {
    
    var color: UIColor
    var total: Double
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(TotalAssetCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: TotalAssetCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(color: color, total: total)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        false
    }
}
