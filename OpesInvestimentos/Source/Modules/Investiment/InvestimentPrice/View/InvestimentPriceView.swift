//
//  InvestimentPriceView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentPriceView: UIView {

    private var viewModel: InvestimentPriceViewModelProtocol!
    private var buttons: [UIButton] = []

    init(viewModel: InvestimentPriceViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.delegate = self
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var chartView = PricesChartView()
    private lazy var detailsView = PricesDetailView()
    
    private lazy var weekPeriodButton: UIButton = {
        let button = UIButton(style: .primary, text: "7D")
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var oneMonthPeriodButton: UIButton = {
        let button = UIButton(style: .secondary, text: "1M")
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var threeMonthPeriodButton: UIButton = {
        let button = UIButton(style: .secondary, text: "3M")
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var sixMonthPeriodButton: UIButton = {
        let button = UIButton(style: .secondary, text: "6M")
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didPressButton(sender: UIButton) {
        guard let data = self.viewModel.viewData?.prices else { return }
        
        buttons.forEach { button in
            button.changeStatus(selected: button == sender)
        }

        switch(sender){
        case weekPeriodButton:
            chartView.updateData(prices: data, period: .week)
        case oneMonthPeriodButton:
            chartView.updateData(prices: data, period: .oneMonth)
        case threeMonthPeriodButton:
            chartView.updateData(prices: data, period: .threeMonth)
        case sixMonthPeriodButton:
            chartView.updateData(prices: data, period: .all)
        default:
            break
        }
    }
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
}

extension InvestimentPriceView: InvestimentPriceViewProtocol {}

extension InvestimentPriceView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .white
        buttons = [weekPeriodButton,
                   oneMonthPeriodButton,
                   threeMonthPeriodButton,
                   sixMonthPeriodButton]
    }
    
    func setupHierarchy() {
        buttonsStack.addArrangedSubview(weekPeriodButton)
        buttonsStack.addArrangedSubview(oneMonthPeriodButton)
        buttonsStack.addArrangedSubview(threeMonthPeriodButton)
        buttonsStack.addArrangedSubview(sixMonthPeriodButton)

        addSubview(detailsView)
        addSubview(buttonsStack)
        addSubview(chartView)
    }
    
    func setupConstraints() {
        detailsView.constraint { view in
            [view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
             view.leadingAnchor.constraint(equalTo: leadingAnchor),
             view.trailingAnchor.constraint(equalTo: trailingAnchor)]
        }
        
        chartView.constraint { view in
            [view.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 10),
             view.leadingAnchor.constraint(equalTo: leadingAnchor),
             view.trailingAnchor.constraint(equalTo: trailingAnchor)]
        }
        
        buttonsStack.constraint { view in
            [view.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 10),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)]
        }
    }
}

extension InvestimentPriceView: InvestimentPriceViewModelDelegate {

    func onLoadPrice() {
        if let data = self.viewModel.viewData {
            guard let prices = data.prices,
                  let currentPrice = data.currentPrice
            else { return }

            chartView.updateData(prices: prices)
            detailsView.configure(price: currentPrice, variation: data.variation, asset: data.asset)
        }
    }
}
