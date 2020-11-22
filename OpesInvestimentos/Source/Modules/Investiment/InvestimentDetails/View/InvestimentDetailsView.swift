//
//  InvestimentDetailsView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 17/11/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentDetailsView: UIView {

    private var viewModel: InvestimentDetailsViewModelProtocol!

    init(viewModel: InvestimentDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var incomeAndProfitsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private lazy var totalViewContent: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var totalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.viewData?.asset.symbol
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 15)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.viewData?.asset.total.formatCurrency()
        label.textColor = .appBlue
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Medium", size: 25)
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var yieldedStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var yieldedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rendimento"
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 13)
        return label
    }()
    
    private lazy var yieldedValueLabel: UILabel = {
        let label = UILabel()
        let yielded = viewModel.viewData?.yielded
        label.textColor = yielded?.sign == .plus ? .appPositive : .appNegative
        label.textAlignment = .left
        label.text = yielded.formatPercent()
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private lazy var appreciationStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var appreciationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Valorização"
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 13)
        return label
    }()
    
    private lazy var appreciationValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = viewModel.viewData?.appreciation.formatCurrency()
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private var dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()
    
    private lazy var incomeAndProfitsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rendimentos e Lucros"
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        return label
    }()
    
    private lazy var amountInvestedView: UIView = {
        let data = viewModel.viewData
        let averagePrice = data?.asset.averagePrice.formatCurrency() ?? ""
        let quantity = String(data?.asset.quantity ?? 0)

        return InvestimentDetailsItemView(title: "Valor Investido",
                                          subtitle: "\(averagePrice) (preço médio) x \(quantity) unidades",
                                          description: data?.amountInvested.formatCurrency() ?? "")
    }()
    
    private lazy var currentTotalView: UIView = {
        let data = viewModel.viewData
        let price = data?.asset.price
        let quantity = String(data?.asset.quantity ?? 0)

        return InvestimentDetailsItemView(title: "Total Atual",
                                          subtitle: "\(price.formatCurrency()) x \(quantity) unidades",
                                          description: data?.asset.total.formatCurrency() ?? "")
    }()
    
    private lazy var paymentReceivedView: UIView = {
        let paymentReceived = viewModel.viewData?.asset.paymentReceived

        return InvestimentDetailsItemView(title: "Pagamentos Recebidos",
                                          description: paymentReceived.formatCurrency() )
    }()
}

extension InvestimentDetailsView: InvestimentPriceViewProtocol {}

extension InvestimentDetailsView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .white
    }
    
    func setupHierarchy() {
        totalStack.addArrangedSubview(symbolLabel)
        totalStack.addArrangedSubview(valueLabel)
        totalViewContent.addSubview(totalStack)

        yieldedStack.addArrangedSubview(yieldedTitleLabel)
        yieldedStack.addArrangedSubview(yieldedValueLabel)
        appreciationStack.addArrangedSubview(appreciationTitleLabel)
        appreciationStack.addArrangedSubview(appreciationValueLabel)
        infoStack.addArrangedSubview(yieldedStack)
        infoStack.addArrangedSubview(dividerLineView)
        infoStack.addArrangedSubview(appreciationStack)
        
        incomeAndProfitsStack.addArrangedSubview(incomeAndProfitsTitleLabel)
        incomeAndProfitsStack.addArrangedSubview(amountInvestedView)
        incomeAndProfitsStack.addArrangedSubview(currentTotalView)
        incomeAndProfitsStack.addArrangedSubview(paymentReceivedView)

        addSubview(totalViewContent)
        addSubview(infoStack)
        addSubview(incomeAndProfitsStack)
    }
    
    func setupConstraints() {
        totalViewContent.constraint { view in
            [view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
             view.heightAnchor.constraint(equalToConstant: 80)]
        }
        
        totalStack.constraint { view in
            [view.topAnchor.constraint(equalTo: totalViewContent.topAnchor, constant: 20),
             view.leadingAnchor.constraint(equalTo: totalViewContent.leadingAnchor, constant: 15),
             view.trailingAnchor.constraint(equalTo: totalViewContent.trailingAnchor, constant: -15)]
        }
        
        infoStack.constraint { view in
            [view.topAnchor.constraint(equalTo: totalViewContent.bottomAnchor, constant: 10),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
             view.heightAnchor.constraint(equalToConstant: 40)]
        }
        
        incomeAndProfitsStack.constraint { view in
            [view.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 40),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
        
        dividerLineView.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 0.5),
             view.heightAnchor.constraint(equalTo: infoStack.heightAnchor)]
        }
    }
}
