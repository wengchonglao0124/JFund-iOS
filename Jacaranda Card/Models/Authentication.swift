//
//  Authentication.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 3/12/2022.
//

import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
}
