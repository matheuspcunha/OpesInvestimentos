//
//  DateHeader.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 10/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class DateHeader: UIView {

    private let date: String

    init(date: String) {
        self.date = date
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 17)
        label.text = date
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
}

extension DateHeader: ViewCodeProtocol {

    func setupHierarchy() {
        addSubviewWithConstraints(subview: dateLabel, insets: UIEdgeInsets(top: 10, left: 20, bottom: -10, right: -20))
    }
}
