//
//  ImportCEIView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 20/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class ImportCEIView: UIView {
    
    private var viewModel: ImportCEIViewModelProtocol!

    init(viewModel: ImportCEIViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
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
        UILabel(style: .title, text: "Importar do CEI")
    }()
    
    private lazy var descriptionLabel: UILabel = {
        UILabel(style: .description, text: "Para começar a utilizar o Opes, ative sua conta entrando com sua senha do Canal Eletrônico do Investidor(CEI).\n\nFique tranquilo, sua senha é criptograda e nós não temos acesso. O portal do CEI é apenas para leitura, nada será alterado.")
    }()
    
    private lazy var cpfField: FieldView = {
        FieldView(title: "CPF", placeholder: "123.456.789-10", type: .email, isEnabled: false)
    }()
    
    private lazy var passwordField: FieldView = {
        FieldView(title: "Senha", placeholder: "••••••••", type: .password)
    }()
    
    private lazy var importButton: UIButton = {
        let button = UIButton(style: .primary, text: "Entrar")
        button.addTarget(self, action: #selector(importTapped), for: .touchUpInside)
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
    
    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    
    @objc private func backTapped(sender: UIButton) {
        viewModel.backScreen()
    }
    
    @objc private func importTapped(sender: UIButton) {
        viewModel.importFromCEI(password: passwordField.text)
    }
    
    @objc private func forgotPasswordTapped(sender: UIButton) {
        viewModel.forgotPassword()
    }
}

extension ImportCEIView: ImportCEIViewProtocol {
    
}

extension ImportCEIView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .appBackground
        TextFieldResponder.shared.add([cpfField.field, passwordField.field])
    }
    
    func setupHierarchy() {
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(descriptionLabel)

        fieldsStack.addArrangedSubview(cpfField)
        fieldsStack.addArrangedSubview(passwordField)
        
        buttonsStack.addArrangedSubview(importButton)
        buttonsStack.addArrangedSubview(forgotPasswordButton)
        
        addSubview(backButton)
        addSubview(labelsStack)
        addSubview(fieldsStack)
        addSubview(buttonsStack)
    }
    
    func setupConstraints() {
        backButton.constraint { view in
            [view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40)]
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
            [view.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 40),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
    }
}

