//
//  UIView+Constraints.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 15/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

extension UIView {
    func constraint(_ closure: (UIView) -> [NSLayoutConstraint]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(closure(self))
    }
}
