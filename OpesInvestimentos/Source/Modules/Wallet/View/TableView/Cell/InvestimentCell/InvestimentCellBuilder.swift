//
//  InvestimentCellBuilder.swift
//  TableViewFactoryTest
//
//  Created by Matheus Cunha on 30/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

struct InvestimentCellBuilder: TableViewCellBuilder {
    
    var model: Investiment
    
    var cellHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    func registerCellIdentifier(in tableView: UITableView) {
        tableView.register(InvestimentCell.self)
    }

    func tableViewCell(at indexPath: IndexPath, on tableView: UITableView) -> UITableViewCell {
        let cell: InvestimentCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(value: model.value.formatCurrency(), type: model.type)
        return cell
    }

    func tableViewShouldSelectCell(_ tableView: UITableView) -> Bool {
        true
    }

    func tableViewDidSelectCell(_ tableView: UITableView) {
        print("did select cell")
    }
}
