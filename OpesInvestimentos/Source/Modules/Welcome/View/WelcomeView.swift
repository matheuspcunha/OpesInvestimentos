//
//  WelcomeView.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 15/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

final class WelcomeView: UIView {
    
    private var viewModel: WelcomeViewModelProtocol?

    init(viewModel: WelcomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var logoImage: UIImageView = {
        let image = #imageLiteral(resourceName: "logo_dark_mode")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        UILabel(style: .title, text: "Seja bem-vindo(a)!")
    }()
    
    private lazy var descriptionLabel: UILabel = {
        UILabel(style: .description, text: "No Opes você pode acompanhar seus investimentos na Bolsa de Valores e no Tesouro Direto, tudo em um só lugar!")
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(style: .primary, text: "Entrar na Minha Conta")
        button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(style: .secondary, text: "Criar Minha Conta")
        button.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
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
    
    @objc private func goToLogin(sender: UIButton) {
        viewModel?.loginScreen()
    }
    
    @objc private func goToRegister(sender: UIButton) {
        viewModel?.registerScreen()
    }
}

extension WelcomeView: WelcomeViewProtocol {
    
}

extension WelcomeView: ViewCodeProtocol {
    
    func additionalSetup() {
        backgroundColor = .appBackground
    }
    
    func setupHierarchy() {
        labelsStack.addArrangedSubview(welcomeLabel)
        labelsStack.addArrangedSubview(descriptionLabel)

        buttonsStack.addArrangedSubview(loginButton)
        buttonsStack.addArrangedSubview(registerButton)

        addSubview(logoImage)
        addSubview(labelsStack)
        addSubview(buttonsStack)
    }
    
    func setupConstraints() {
        logoImage.constraint { view in
            [view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
             view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2)]
        }
        
        labelsStack.constraint { view in
            [view.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 70),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
        
        buttonsStack.constraint { view in
            [view.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 50),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
    }
}
