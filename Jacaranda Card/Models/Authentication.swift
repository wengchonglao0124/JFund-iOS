//
//  Authentication.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 3/12/2022.
//

import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    init() {
        retrievingValidation()
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
        UserDefaults.standard.set(success, forKey: "loginValidation")
    }
    
    func retrievingValidation() {
        self.isValidated = UserDefaults.standard.bool(forKey: "loginValidation")
    }
}
