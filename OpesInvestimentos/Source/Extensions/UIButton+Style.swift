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
    
    convenience init(style: StyleButton, text: String) {
        self.init()
        
        switch style {
        case .primary:
            primary(text)
        case .secondary:
            secondary(text)
        default:
            break
        }
    }
    
    convenience init(style: StyleButton) {
        self.init()
        
        if style == .back {
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
}
