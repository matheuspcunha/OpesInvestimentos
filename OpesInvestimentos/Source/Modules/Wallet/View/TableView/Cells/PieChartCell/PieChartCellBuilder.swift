//
//  PieChartCellBuilder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 06/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct PieChartCellBuilder: TableViewCellBuilder {
    
    var model: [Investiment]
    
    var cellHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(PieChartCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: PieChartCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(investiments: model)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        true
    }

    func tableViewDidSelectCell(_ tableView: UITableView) {
        print("did select cell")
    }
}
