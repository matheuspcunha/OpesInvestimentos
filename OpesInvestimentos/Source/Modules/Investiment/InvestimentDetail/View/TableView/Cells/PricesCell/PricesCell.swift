//
//  PricesCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class PricesCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(price: Price, asset: InvestimentAsset) {
        titleLabel.text = asset.name.uppercased()
        valueLabel.text = price.close.formatCurrency()
        highValueLabel.text = price.high.formatCurrency()
        lowValueLabel.text = price.low.formatCurrency()
        volumeValueLabel.text = price.volume?.formatCurrency()
    }

    private lazy var viewContent: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Roman", size: 15)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appBlue
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Medium", size: 25)
        return label
    }()
    
    //Detail
    private lazy var detailStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    private lazy var totalCostStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var highTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Alta"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Roman", size: 13)
        return label
    }()
    
    private lazy var highValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appPositive
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private lazy var resultStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var volumeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Volume"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Roman", size: 13)
        return label
    }()
    
    private lazy var volumeValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private lazy var variationStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var lowTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Baixa"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Roman", size: 13)
        return label
    }()
    
    private lazy var lowValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .appNegative
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

extension PricesCell: ViewCodeProtocol {

    func additionalSetup() {
        backgroundColor = .clear
    }

    func setupHierarchy() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        
        viewContent.addSubview(stackView)
        
        //Detail
        totalCostStack.addArrangedSubview(highTitleLabel)
        totalCostStack.addArrangedSubview(highValueLabel)

        variationStack.addArrangedSubview(lowTitleLabel)
        variationStack.addArrangedSubview(lowValueLabel)
        
        resultStack.addArrangedSubview(volumeTitleLabel)
        resultStack.addArrangedSubview(volumeValueLabel)

        detailStack.addArrangedSubview(totalCostStack)
        detailStack.addArrangedSubview(dividerLineView1)
        detailStack.addArrangedSubview(variationStack)
        detailStack.addArrangedSubview(dividerLineView2)
        detailStack.addArrangedSubview(resultStack)
        
        addSubview(viewContent)
        addSubview(detailStack)
    }
    
    func setupConstraints() {
        viewContent.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor, constant: 20),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
             view.heightAnchor.constraint(equalToConstant: 80)]
        }
        
        stackView.constraint { view in
            [view.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 15),
             view.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 15),
             view.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -15)]
        }
        
        detailStack.constraint { view in
            [view.topAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: 15),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)]
        }
        
        dividerLineView1.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 0.5),
             view.heightAnchor.constraint(equalTo: detailStack.heightAnchor)]
        }
        
        dividerLineView2.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 0.5),
             view.heightAnchor.constraint(equalTo: detailStack.heightAnchor)]
        }
    }
}
