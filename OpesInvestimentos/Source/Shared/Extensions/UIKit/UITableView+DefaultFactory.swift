//
//  UITableView+DefaultFactory.swift
//  TableViewFactoryTest
//
//  Created by Matheus Cunha on 29/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

extension UITableView {
    
    static func standard() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 44
        tableView.backgroundColor = .systemGroupedBackground
        return tableView
    }
    
    
}
