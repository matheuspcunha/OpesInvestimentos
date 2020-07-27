//
//  CustomView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 22/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUIView: UIView {

    @IBInspectable var padding: CGFloat = 0
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}
