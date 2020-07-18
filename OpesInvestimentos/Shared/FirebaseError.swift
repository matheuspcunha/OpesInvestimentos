//
//  FirebaseError.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 02/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import Foundation

enum FirebaseError: Error {
    case emailAlreadyInUse
    case userDisabled
    case invalidEmail
    case invalidCPF
    case networkError
    case weakPassword
    case emptyField
    case unknown
    
    var title: String {
        switch self {
        case .emailAlreadyInUse:
            return "😕"
        case .userDisabled:
            return "😕"
        case .invalidEmail:
            return "Email inválido"
        case .invalidCPF:
            return "CPF inválido"
        case .networkError:
            return "Ops! Erro de conexão 😕"
        case .weakPassword:
            return "Senha fraca"
        case .emptyField:
            return "Campo vázio"
        case .unknown:
            return "😕"
        }
    }
    
    var message: String {
        switch self {
        case .emailAlreadyInUse:
            return "Parece que este email já está sendo utilizado."
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail:
            return "Por favor, entre com um email válido."
        case .invalidCPF:
            return "Por favor, entre com um CPF válido."
        case .networkError:
            return "Verifique sua conexão com a internet e tente novamente."
        case .weakPassword:
            return "Utilize uma senha que contenha: simbolos, caracteres especiais, letras minisculas e maisculas."
        case .emptyField:
            return "Por favor, preencha todos os campos."
        case .unknown:
            return "Por favor, tente novamente mais tarde."
        }
    }
}
