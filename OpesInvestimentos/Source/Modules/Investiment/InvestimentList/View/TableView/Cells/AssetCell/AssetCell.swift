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
        selectionStyle = .none
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(asset: InvestimentAsset) {
        indicatorIconImage.isHidden = (asset.symbol.contains("Tesouro") || asset.averagePrice.isNaN)
        symbolLabel.text = asset.symbol.contains("Tesouro") ? asset.symbol.replacingOccurrences(of: "Tesouro ", with: "") : asset.symbol
        nameLabel.text = asset.name.uppercased()
        totalLabel.text = asset.total.formatCurrency()
        quantityLabel.text = asset.price > 0 ? "\(asset.price.formatCurrency()) x \(asset.quantity) unidades" : ""
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
        stack.alignment = .center
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
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
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
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        return label
    }()

    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Book", size: 12)
        return label
    }()
    
    private lazy var indicatorIconImage: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "disclosure_indicator") {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .opaqueSeparator
        return imageView
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

        viewContent.addSubview(indicatorIconImage)
        viewContent.addSubview(stackView)

        addSubview(viewContent)
    }

    func setupConstraints() {
        viewContent.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
             view.heightAnchor.constraint(equalToConstant: 65)]
        }

        stackView.constraint { view in
            [view.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 15),
             view.trailingAnchor.constraint(equalTo: indicatorIconImage.leadingAnchor, constant: -15),
             view.centerYAnchor.constraint(equalTo: viewContent.centerYAnchor)]
        }
        
        indicatorIconImage.constraint { view in
            [view.widthAnchor.constraint(equalToConstant: 15),
             view.heightAnchor.constraint(equalTo: view.widthAnchor),
             view.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -15),
             view.centerYAnchor.constraint(equalTo: viewContent.centerYAnchor)]
        }
    }
}
