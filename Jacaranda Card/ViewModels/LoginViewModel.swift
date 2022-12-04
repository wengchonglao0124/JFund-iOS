//
//  LoginViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 2/12/2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        WebService.login(email: email, password: password) { result in
            
            switch result {
            case .success(let data):
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
