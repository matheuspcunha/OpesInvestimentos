//
//  AssetCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 23/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class AssetCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(asset: InvestimentAsset) {
        symbolLabel.text = asset.symbol
        symbolLabel.textColor = asset.color
        nameLabel.text = asset.name
        totalLabel.text = asset.total.formatCurrency()
        quantityLabel.text = "\(asset.price) x \(asset.quantity) unidades"
    }
    
    private lazy var viewContent: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var leftStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var rightStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 12)
        return label
    }()

    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Book", size: 12)
        return label
    }()
}

extension AssetCell: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .appBackground
    }

    func setupHierarchy() {
        leftStack.addArrangedSubview(symbolLabel)
        leftStack.addArrangedSubview(nameLabel)
        
        rightStack.addArrangedSubview(totalLabel)
        rightStack.addArrangedSubview(quantityLabel)
        
        stackView.addArrangedSubview(leftStack)
        stackView.addArrangedSubview(rightStack)
        
        viewContent.addSubview(stackView)
        
        addSubview(viewContent)
    }
    
    func setupConstraints() {
        viewContent.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
             view.heightAnchor.constraint(equalToConstant: 50)]
        }
        
        stackView.constraint { view in
            [view.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 15),
             view.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -15),
             view.centerYAnchor.constraint(equalTo: viewContent.centerYAnchor)]
        }
    }
}
