//
//  UICollectionView+Empty.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 25/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func restore() {
        self.backgroundView = nil
        self.isScrollEnabled = true
    }
    
     func setLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
        
        self.backgroundView = activityIndicator
        self.isScrollEnabled = false
    }
}
