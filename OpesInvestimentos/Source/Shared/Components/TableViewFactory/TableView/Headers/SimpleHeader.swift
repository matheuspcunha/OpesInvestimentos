//
//  SimpleHeader.swift
//  Example
//
//  Created by Pedro M. Zaroni on 15/08/20.
//  Copyright © 2020 Dextra. All rights reserved.
//

import UIKit

final class SimpleHeader: UIView {

    private let title: String
    private let textStyle: UIFont
    private let insets: UIEdgeInsets

    init(title: String,
         textStyle: UIFont = UIFont(name: "Avenir-Medium", size: 25)!,
         insets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 40,
                                             bottom: -10, right: -40)) {
        
        self.title = title
        self.textStyle = textStyle
        self.insets = insets
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = textStyle
        label.text = title
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
}

extension SimpleHeader: ViewCodeProtocol {
    func setupHierarchy() {
        addSubviewWithConstraints(subview: titleLabel, insets: insets)
    }

    func setupConstraints() {}
}
