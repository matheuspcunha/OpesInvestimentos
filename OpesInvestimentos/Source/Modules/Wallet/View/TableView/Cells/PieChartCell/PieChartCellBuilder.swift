//
//  PieChartCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 06/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct PieChartCellBuilder: TableViewCellBuilder {
    
    var model: WalletViewDataProtocol
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(PieChartCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: PieChartCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(investiments: model.investiments, totalWallet: model.total)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        false
    }
}
