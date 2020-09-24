//
//  UITableView+DeleteRows.swift
//  TableViewFactoryTest
//
//  Created by Matheus Cunha on 29/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

extension UITableView {
    
    func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation,
                    completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)

        beginUpdates()
        deleteRows(at: indexPaths, with: animation)
        endUpdates()

        CATransaction.commit()
    }
}
