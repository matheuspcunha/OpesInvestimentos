//
//  StatementCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 07/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class StatementCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: StatementCellViewModel) {
        codeLabel.text = viewModel.code
        priceLabel.text = viewModel.price
        quantityLabel.text = viewModel.unityPrice
        typeLabel.text = viewModel.operationType
    }
    
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
    
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Book", size: 16)
        return label
    }()

    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Book", size: 13)
        return label
    }()

    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appBlue
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 12)
        return label
    }()
}

extension StatementCell: ViewCodeProtocol {
    
    func setupHierarchy() {

        leftStack.addArrangedSubview(codeLabel)
        leftStack.addArrangedSubview(typeLabel)
        
        rightStack.addArrangedSubview(priceLabel)
        rightStack.addArrangedSubview(quantityLabel)
        
        stackView.addArrangedSubview(leftStack)
        stackView.addArrangedSubview(rightStack)

        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor, constant: 5),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)]
        }
    }
}
