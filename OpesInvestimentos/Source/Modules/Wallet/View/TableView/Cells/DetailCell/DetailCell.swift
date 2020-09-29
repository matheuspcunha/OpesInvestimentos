//
//  DetailCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 19/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class DetailCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(totalCost: Double, result: Double, variation: Double) {
        totalCostValueLabel.text = totalCost.formatCurrency()
        resultValueLabel.text = result.formatCurrency()
        variationValueLabel.text =  variation.formatPercent()
        variationValueLabel.textColor = result.sign == .plus ? .appPositive : .appNegative
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var totalCostStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var totalCostTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Custo Total"
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 13)
        return label
    }()
    
    private lazy var totalCostValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private lazy var resultStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var resultTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Resultado"
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 13)
        return label
    }()
    
    private lazy var resultValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private lazy var variationStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var variationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Variação"
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 13)
        return label
    }()
    
    private lazy var variationValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private var dividerLineView1: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()
    
    private var dividerLineView2: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()
}

extension DetailCell: ViewCodeProtocol {
    
    func setupHierarchy() {
        totalCostStack.addArrangedSubview(totalCostTitleLabel)
        totalCostStack.addArrangedSubview(totalCostValueLabel)

        variationStack.addArrangedSubview(variationTitleLabel)
        variationStack.addArrangedSubview(variationValueLabel)
        
        resultStack.addArrangedSubview(resultTitleLabel)
        resultStack.addArrangedSubview(resultValueLabel)

        stackView.addArrangedSubview(totalCostStack)
        stackView.addArrangedSubview(dividerLineView1)
        stackView.addArrangedSubview(variationStack)
        stackView.addArrangedSubview(dividerLineView2)
        stackView.addArrangedSubview(resultStack)

        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)]
        }
        
        dividerLineView1.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 0.5),
             view.heightAnchor.constraint(equalTo: stackView.heightAnchor)]
        }
        
        dividerLineView2.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 0.5),
             view.heightAnchor.constraint(equalTo: stackView.heightAnchor)]
        }
    }
}

