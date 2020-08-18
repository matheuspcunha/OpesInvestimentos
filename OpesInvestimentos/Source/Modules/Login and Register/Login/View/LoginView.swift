//
//  LoginView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 16/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class LoginView: UIView {

    private var viewModel: LoginViewModel!
    
    init(viewModel: LoginViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton(style: .back)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(style: .title, text: "Login")
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(style: .description, text: "Entre com seu e-mail e senha cadastrados no Opes.")
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(style: .primary, text: "Entrar")
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(style: .secondary, text: "Esqueci Minha Senha")
        button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    
    private lazy var emailField: FieldView = {
        FieldView(title: "E-mail", placeholder: "nome@email.com", type: .email)
    }()
    
    private lazy var passwordField: FieldView = {
        FieldView(title: "Senha", placeholder: "••••••••", type: .password)
    }()
    
    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    @objc private func loginTapped(sender: UIButton) {
        viewModel.login(withEmail: emailField.field.text, password: passwordField.field.text)
    }
    
    @objc private func forgotPasswordTapped(sender: UIButton) {
        viewModel.forgotPassword()
    }
    
    @objc private func backTapped(sender: UIButton) {
        viewModel.backScreen()
    }
}

extension LoginView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .appBackground
        TextFieldResponder.shared.add([emailField.field, passwordField.field])
    }
    
    func setupHierarchy() {
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(descriptionLabel)
        
        buttonsStack.addArrangedSubview(loginButton)
        buttonsStack.addArrangedSubview(forgotPasswordButton)
        
        fieldsStack.addArrangedSubview(emailField)
        fieldsStack.addArrangedSubview(passwordField)

        addSubview(backButton)
        addSubview(labelsStack)
        addSubview(buttonsStack)
        addSubview(fieldsStack)
    }
    
    func setupConstraints() {
        backButton.constraint { view in
            [view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.heightAnchor.constraint(equalToConstant: 50),
             view.widthAnchor.constraint(equalTo: view.heightAnchor)]
        }
        
        labelsStack.constraint { view in
            [view.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
        
        fieldsStack.constraint { view in
            [view.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 30),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
        
        buttonsStack.constraint { view in
            [view.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 50),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
    }
}
