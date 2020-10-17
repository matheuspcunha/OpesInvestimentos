//
//  PricesDetailView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class PricesDetailView: UIView {
    
    init() {
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(price: Price, variation: (Double, Double), asset: InvestimentAsset) {
        titleLabel.text = asset.name.uppercased()
        valueLabel.text = price.close.formatCurrency()
        highValueLabel.text = price.high.formatCurrency()
        lowValueLabel.text = price.low.formatCurrency()
        volumeValueLabel.text = price.volume?.formatCurrency()
        lastUpdateLabel.text = Formatter.dateTimeFormatter.string(from: price.date)
        variationValueLabel.text = "\(variation.0.formatCurrency(symbol: false)) (\(variation.1.formatPercent()))"
        variationValueLabel.textColor = variation.0.sign == .plus ? .appPositive : .appNegative
        configureVariationIcon(positive: variation.0.sign == .plus)
    }
    
    private lazy var viewContent: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()

    private lazy var leftStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()

    private lazy var rightStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.alignment = .trailing
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
    
    private lazy var variationStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var variationValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    private lazy var lastUpdateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .darkGray
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()
    
    // Detail
    private lazy var detailStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    private lazy var highValueStack: UIStackView = {
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
    
    private lazy var lowValueStack: UIStackView = {
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
    
    private lazy var variationIconImage: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "disclosure_indicator") {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .opaqueSeparator

        return imageView
    }()
    
    private func configureVariationIcon(positive: Bool) {
        
        if let image = positive ? UIImage(named: "up") : UIImage(named: "down") {
            variationIconImage.image = image.withRenderingMode(.alwaysTemplate)
        }
        variationIconImage.tintColor = positive ? .appPositive : .appNegative
    }
}

extension PricesDetailView: ViewCodeProtocol {

    func additionalSetup() {
        backgroundColor = .clear
    }

    func setupHierarchy() {
        
        leftStack.addArrangedSubview(titleLabel)
        leftStack.addArrangedSubview(valueLabel)

        variationStack.addArrangedSubview(variationValueLabel)
        variationStack.addArrangedSubview(variationIconImage)

        rightStack.addArrangedSubview(lastUpdateLabel)
        rightStack.addArrangedSubview(variationStack)

        stackView.addArrangedSubview(leftStack)
        stackView.addArrangedSubview(rightStack)
        
        viewContent.addSubview(stackView)
        
        // Detail
        highValueStack.addArrangedSubview(highTitleLabel)
        highValueStack.addArrangedSubview(highValueLabel)

        lowValueStack.addArrangedSubview(lowTitleLabel)
        lowValueStack.addArrangedSubview(lowValueLabel)
        
        resultStack.addArrangedSubview(volumeTitleLabel)
        resultStack.addArrangedSubview(volumeValueLabel)

        detailStack.addArrangedSubview(highValueStack)
        detailStack.addArrangedSubview(dividerLineView1)
        detailStack.addArrangedSubview(lowValueStack)
        detailStack.addArrangedSubview(dividerLineView2)
        detailStack.addArrangedSubview(resultStack)
        
        addSubview(viewContent)
        addSubview(detailStack)
    }
    
    func setupConstraints() {
        viewContent.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
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
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
             view.bottomAnchor.constraint(equalTo: bottomAnchor)]
        }
        
        dividerLineView1.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 0.5),
             view.heightAnchor.constraint(equalTo: detailStack.heightAnchor)]
        }
        
        dividerLineView2.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 0.5),
             view.heightAnchor.constraint(equalTo: detailStack.heightAnchor)]
        }
        
        variationIconImage.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 20),
             view.heightAnchor.constraint(equalTo: view.widthAnchor),
             view.centerYAnchor.constraint(equalTo: variationStack.centerYAnchor)]
        }
    }
}
