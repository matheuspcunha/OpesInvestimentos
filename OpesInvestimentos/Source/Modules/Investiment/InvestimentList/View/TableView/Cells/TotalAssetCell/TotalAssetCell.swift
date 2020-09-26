//
//  TotalAssetCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 24/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class TotalAssetCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(color: UIColor, total: Double) {
        valueLabel.text = total.formatCurrency()
        valueLabel.textColor = color
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "TOTAL INVESTIDO"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Roman", size: 15)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 25)
        return label
    }()
}

extension TotalAssetCell: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
                
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor, constant: 15),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)]
        }
    }
}

