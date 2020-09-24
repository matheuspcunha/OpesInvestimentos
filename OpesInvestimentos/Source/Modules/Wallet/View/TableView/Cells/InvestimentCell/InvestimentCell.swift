//
//  InvestimentCell.swift
//  TableViewFactoryTest
//
//  Created by Matheus Cunha on 30/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(value: String, type: InvestimentType) {
        typeLabel.text = type.name.uppercased()
        valueLabel.text = value
        valueLabel.textColor = type.color
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 12)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Medium", size: 20)
        return label
    }()
    
    private lazy var arrowIconLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.textColor = .opaqueSeparator
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private lazy var dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        view.constraint { view in
            [view.heightAnchor.constraint(equalToConstant: 0.5)]
        }
        return view
    }()
}

extension InvestimentCell: ViewCodeProtocol {
    
    func setupHierarchy() {
        contentStack.addSpacing(5)
        contentStack.addArrangedSubview(typeLabel)
        contentStack.addArrangedSubview(valueLabel)
        contentStack.addSpacing(5)
        contentStack.addArrangedSubview(dividerLineView)
        
        stackView.addArrangedSubview(contentStack)
        stackView.addArrangedSubview(arrowIconLabel)
        
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
             view.bottomAnchor.constraint(equalTo: bottomAnchor)]
        }
        
        arrowIconLabel.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 25),
             view.heightAnchor.constraint(equalTo: view.heightAnchor)]
        }
    }
}
