//
//  WalletView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 23/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class WalletView: UIView {

    private var viewModel: WalletViewModelProtocol!
    
    init(viewModel: WalletViewModelProtocol) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()

    private lazy var nameLabel: UILabel = {
        UILabel(style: .title, text: "Olá, Everton! 🤑")
    }()
    
    private lazy var stockInvestimentView: UIView = {
        WalletInvestimentView(value: "R$ 10,00", type: .stock)
    }()
    
    private lazy var fundInvestimentView: UIView = {
        WalletInvestimentView(value: "R$ 10,00", type: .funds)
    }()
    
    private lazy var treasureInvestimentView: UIView = {
        WalletInvestimentView(value: "R$ 10,00", type: .treasure)
    }()
}

extension WalletView: WalletViewProtocol {

}

extension WalletView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .white
    }
    
    func setupHierarchy() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(stockInvestimentView)
        stackView.addArrangedSubview(fundInvestimentView)
        stackView.addArrangedSubview(treasureInvestimentView)
        
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.constraint { view in
            [view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
    }
}
