//
//  UITextField+Custom.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

enum TextFieldType {
    case text
    case password
    case email
}

extension UITextField {
    
    convenience init(placeholder: String? = nil, type: TextFieldType) {
        self.init()
        
        setType(type)
        self.placeholder = placeholder
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.font = UIFont(name: "Avenir-Book", size: 13)
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        self.leftViewMode = .always
    }
    
    private func setType(_ type: TextFieldType) {
        switch type {
        case .email:
            self.textContentType = .emailAddress
            self.keyboardType = .emailAddress
        case .password:
            self.textContentType = .password
            self.keyboardType = .default
            self.isSecureTextEntry = true
        default:
            break
        }
    }
}
