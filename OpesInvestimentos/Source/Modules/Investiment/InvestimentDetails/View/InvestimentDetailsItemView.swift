//
//  InvestimentDetailsItemView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 21/11/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class InvestimentDetailsItemView: UIView {

    private let titleText: String
    private let subtitleText: String?
    private let descriptionText: String

    init(title: String,
         subtitle: String? = nil,
         description: String) {
        self.titleText =  title
        self.subtitleText = subtitle
        self.descriptionText = description
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.text = titleText
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.text = subtitleText
        label.font = UIFont(name: "Avenir-Book", size: 13)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .right
        label.text = descriptionText
        label.font = UIFont(name: "Avenir-Book", size: 15)
        return label
    }()

    private lazy var blankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .right
        label.font = UIFont(name: "Avenir-Book", size: 13)
        return label
    }()
}

extension InvestimentDetailsItemView: ViewCodeProtocol {
    
    func setupHierarchy() {
        leftStack.addArrangedSubview(titleLabel)
        leftStack.addArrangedSubview(subtitleLabel)
        
        rightStack.addArrangedSubview(descriptionLabel)
        rightStack.addArrangedSubview(blankLabel)
        
        stackView.addArrangedSubview(leftStack)
        stackView.addArrangedSubview(rightStack)

        addSubviewWithConstraints(subview: stackView)
    }
    
    func setupConstraints() {}
    
    func additionalSetup() {
        blankLabel.isHidden = subtitleText == nil
    }
}
