//
//  UITableView+Empty.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 19/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        titleLabel.text = title
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.darkGray
        messageLabel.font = UIFont(name: "Avenir-Light", size: 20)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
        self.isScrollEnabled = false
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        self.isScrollEnabled = true
    }
    
     func setLoading() {
        let loadingView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.frame = CGRect(x: loadingView.bounds.width / 2, y: loadingView.bounds.height / 2, width: 5, height: 5)
        activityIndicator.style = .medium
        activityIndicator.startAnimating()
        
        loadingView.addSubview(activityIndicator)

        self.backgroundView = loadingView
        self.separatorStyle = .none
        self.isScrollEnabled = false
    }
}
