//
//  Field.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class FieldView: UIView {

    private let title: String
    private let placeholder: String?
    private let type: TextFieldType
    private let isEnabled: Bool
    
    init(title: String, placeholder: String? = nil, type: TextFieldType, isEnabled: Bool = true) {
        self.title = title
        self.placeholder = placeholder
        self.type = type
        self.isEnabled = isEnabled
        
        super.init(frame: .zero)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var label: UILabel = {
        UILabel(style: .field, text: self.title)
    }()
    
    lazy var field: UITextField = {
        UITextField(placeholder: self.placeholder, type: self.type, isEnabled: isEnabled)
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    
    lazy var text: String? = {
        field.text
    }()
}

extension FieldView: ViewCodeProtocol {
    
    func setupHierarchy() {
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(field)
        addSubview(stack)
    }
    
    func setupConstraints() {
        stack.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor),
             view.trailingAnchor.constraint(equalTo: trailingAnchor),
             view.bottomAnchor.constraint(equalTo: bottomAnchor)]
        }
    }
}
