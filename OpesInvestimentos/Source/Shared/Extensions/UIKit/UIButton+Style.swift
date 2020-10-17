//
//  UIButton+Style.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 15/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

enum StyleButton {
    case primary
    case secondary
    case back
}

extension UIButton {
    
    convenience init(style: StyleButton, text: String? = nil) {
        self.init()
        
        switch style {
        case .primary:
            guard let text = text else { return }
            primary(text)
        case .secondary:
            guard let text = text else { return }
            secondary(text)
        case .back:
            back()
        }
    }
    
    private func primary(_ text: String) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)
        
        self.backgroundColor = .appBlue
        self.layer.cornerRadius = 5
    }
    
    private func secondary(_ text: String) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(.appBlue, for: .normal)
        self.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)

        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.appBlue.cgColor
    }
    
    private func back() {
        self.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 25)
        self.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        self.contentHorizontalAlignment = .left
        self.tintColor = .appBlue
    }
    
    func changeStatus(selected: Bool) {
        if selected {
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .appBlue
            self.layer.cornerRadius = 5
        } else {
            self.setTitleColor(.appBlue, for: .normal)
            self.backgroundColor = .white
            self.layer.cornerRadius = 5
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.appBlue.cgColor
        }
    }
    
}
