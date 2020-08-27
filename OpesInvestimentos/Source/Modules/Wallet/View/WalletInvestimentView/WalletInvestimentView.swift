//
//  WalletInvestimentView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 25/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class WalletInvestimentView: UIView {
    
    private var value: String!
    private var type: InvestimentType!
    
    init(value: String, type: InvestimentType) {
        super.init(frame: .zero)
        self.value = value
        self.type = type
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = type.name.uppercased()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 12)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = value
        label.textColor = type.color
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Medium", size: 20)
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

extension WalletInvestimentView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.setCustomSpacing(5, after: valueLabel)
        stackView.addArrangedSubview(dividerLineView)
        
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
             view.trailingAnchor.constraint(equalTo: trailingAnchor),
             view.bottomAnchor.constraint(equalTo: bottomAnchor)]
        }
    }
}
