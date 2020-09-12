//
//  RegisterView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 18/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class RegisterView: UIView {

    private var viewModel: RegisterViewModelProtocol!
    
    init(viewModel: RegisterViewModelProtocol) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(style: .back)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        UILabel(style: .title, text: "Registro")
    }()
    
    private lazy var descriptionLabel: UILabel = {
        UILabel(style: .description, text: "Precisamos de alguns dados para consolidar seus investimentos, tudo bem?")
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private lazy var nameField: FieldView = {
        FieldView(title: "Nome", placeholder: "Nome e Sobrenome", type: .email)
    }()
    
    private lazy var cpfField: FieldView = {
        FieldView(title: "CPF", placeholder: "123.456.789-10", type: .password)
    }()
    
    private lazy var emailField: FieldView = {
        FieldView(title: "E-mail", placeholder: "nome@email.com", type: .email)
    }()
    
    private lazy var passwordField: FieldView = {
        FieldView(title: "Senha", placeholder: "••••••••", type: .password)
    }()
    
    private lazy var confirmPasswordField: FieldView = {
        FieldView(title: "Confirme a Senha", placeholder: "••••••••", type: .password)
    }()
    
    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(style: .primary, text: "Vamos lá")
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var fields = [nameField, cpfField, emailField, passwordField, confirmPasswordField]
    
    @objc private func backTapped(sender: UIButton) {
        viewModel.backScreen()
    }
    
    @objc private func registerTapped(sender: UIButton) {
    }
}

extension RegisterView: RegisterViewProtocol {}

extension RegisterView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .appBackground
        TextFieldResponder.shared.add(fields.map({$0.field}))
    }
    
    func setupHierarchy() {
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(descriptionLabel)

        fields.enumerated().forEach{fieldsStack.addArrangedSubview($1)}
        
        containerStackView.addArrangedSubview(backButton)
        containerStackView.addSpacing(20)
        containerStackView.addArrangedSubview(labelsStack)
        containerStackView.addSpacing(30)
        containerStackView.addArrangedSubview(fieldsStack)
        containerStackView.addSpacing(40)
        containerStackView.addArrangedSubview(loginButton)
        
        scrollView.addSubview(containerStackView)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.constraint { view in
            [view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
             view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
             view.widthAnchor.constraint(equalTo: widthAnchor)]
        }
        
        containerStackView.constraint { view in
            [view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
             view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
    }
}
