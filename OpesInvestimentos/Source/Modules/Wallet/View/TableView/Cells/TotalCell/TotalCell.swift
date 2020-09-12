//
//  TotalCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 02/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class TotalCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(value: String) {
        valueLabel.text = value
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
        label.text = "PATRIMÔNIO"
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
}

extension TotalCell: ViewCodeProtocol {
    
    func setupHierarchy() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        
        viewContent.addSubview(stackView)
        
        addSubview(viewContent)
    }
    
    func setupConstraints() {
        viewContent.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
             view.heightAnchor.constraint(equalToConstant: 80)]
        }
        
        stackView.constraint { view in
            [view.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 20),
             view.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 15),
             view.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -15)]
        }
    }
}

