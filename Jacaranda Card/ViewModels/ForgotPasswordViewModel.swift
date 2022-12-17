//
//  ForgotPasswordViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 17/12/2022.
//

import Foundation

class ForgotPasswordViewModel: EmailResendViewModel {
    
    var email: String?
    var newPassword: String?
    
    
    func requestChangePassword(email: String, newPassword: String, completion: @escaping (Bool) -> Void) {
        
        self.email = email
        self.newPassword = newPassword
        
        PasswordService.forgotPassword(email: email, newPassword: newPassword) { result in
            
            switch result {
            case .success:
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    override func emailResend() {
        
        requestChangePassword(email: self.email!, newPassword: self.newPassword!) { success in
            
            if success {
                print(true)
            }
            else {
                print(false)
            }
        }
    }
}
