//
//  UIViewController+Keyboard.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 29/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
