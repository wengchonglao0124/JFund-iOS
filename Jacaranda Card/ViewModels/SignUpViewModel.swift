//
//  SignUpViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 6/12/2022.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    func signUp(email: String, password: String, username: String, completion: @escaping (Bool) -> Void) {
        
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
}
