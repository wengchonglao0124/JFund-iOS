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
                
                let userData = UserData.decode(data)
                UserDefaults.standard.set(userData.UserName, forKey: "userName")
                UserDefaults.standard.set(userData.image, forKey: "userImage")
                
                UserDefaults.standard.set(email, forKey: "userEmail")
                
                let credentials = Credentials.decode(data)
                if KeychainService.saveCredentials(credentials) {
                    completion(true)
                }
                else {
                    completion(false)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
