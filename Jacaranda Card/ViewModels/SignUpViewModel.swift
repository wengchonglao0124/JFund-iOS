//
//  SignUpViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 6/12/2022.
//

import Foundation

class SignUpViewModel: EmailResendViewModel, ObservableObject {
    
    var email: String?
    var password: String?
    var username: String?
    
    func signUp(email: String, password: String, username: String, completion: @escaping (Bool) -> Void) {
        
        self.email = email
        self.password = password
        self.username = username
        
        WebService.signUp(email: email, password: password, username: username) { result in
            
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
        
        signUp(email: self.email!, password: self.password!, username: self.username!) { success in
            
            if success {
                print(true)
            }
            else {
                print(false)
            }
        }
    }
}

// Resend
// Check re-enter email address 
