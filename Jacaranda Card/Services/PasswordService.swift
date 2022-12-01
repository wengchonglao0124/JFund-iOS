//
//  PasswordService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 1/12/2022.
//

import Foundation

class PasswordService {
    
    static func checkSamePasswords(password1: String, password2: String) -> Bool {
        return password1 == password2
    }
}
