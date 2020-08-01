//
//  TextFieldResponder.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 29/07/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class TextFieldResponder: NSObject, UITextFieldDelegate {
    
    static let shared = TextFieldResponder()
    
    private var textFields: [UITextField] = []
    
    var activeTextField: UITextField!

    func add(_ textFields: [UITextField]) {
        self.textFields = textFields
        self.textFields.forEach({ $0.delegate = self })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == textFields.last {
            textField.resignFirstResponder()
        } else {

            for index in 0..<textFields.count {
                if textField == textFields[index] {
                    textFields[index + 1].becomeFirstResponder()
                    break
                }
            }
        }

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}
