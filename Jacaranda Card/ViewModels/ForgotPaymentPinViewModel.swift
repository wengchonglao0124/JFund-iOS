//
//  ForgotPaymentPinViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 18/12/2022.
//

import Foundation

class ForgotPaymentPinViewModel: EmailResendViewModel {
    
    var accessToken: String?
    var newPin: String?
    
    func requestChangePaymentPin(accessToken: String, newPin: String, completion: @escaping (Bool) -> Void) {
        
        self.accessToken = accessToken
        self.newPin = newPin
        
        PasswordService.forgotPaymentPin(accessToken: accessToken, newPin: newPin) { result in
            
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
        
        requestChangePaymentPin(accessToken: self.accessToken!, newPin: self.newPin!) { success in
            
            if success {
                print(true)
            }
            else {
                print(false)
            }
        }
    }
}
