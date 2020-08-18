//
//  UIFont+Custom.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

enum Style {
    case title
    case description
    case field
}

extension UILabel {
    
    convenience init(style: Style, text: String) {
        self.init()
        
        switch style {
        case .title:
            title(text)
        case .description:
            description(text)
        case .field:
            field(text)
        }
    }
    
    private func title(_ text: String) {
        self.textColor = UIColor.darkGray
        self.font = UIFont(name: "Avenir-Medium", size: 25)
        self.text = text
        self.textAlignment = .left
    }
    
    private func description(_ text: String) {
        self.textColor = UIColor.darkGray
        self.font = UIFont(name: "Avenir-Light", size: 16)
        self.text = text
        self.numberOfLines = 0
        self.textAlignment = .justified
    }
    
    private func field(_ text: String) {
        self.textColor = UIColor.darkGray
        self.font = UIFont(name: "Avenir-Light", size: 13)
        self.text = text
        self.numberOfLines = 0
        self.textAlignment = .justified
    }
}
