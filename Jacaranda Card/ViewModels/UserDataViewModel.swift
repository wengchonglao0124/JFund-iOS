//
//  UserDataViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 5/12/2022.
//

import Foundation


struct Balance: Codable {
    var balanceof: String?
}


class UserDataViewModel: ObservableObject {
    
    @Published var userBalance = "..."
    @Published var didSetupPin = true
    
    @Published var userName = "..."
    @Published var userImage = "#74c69d"
    
    
    init() {
        updateDidSetupPaymentPin()
        updateUserName()
        updateUserImage()
    }
    
    
    func getUserID() -> String {
        
        guard let userID = KeychainService.getCredentials()?.UserID else {
            return ""
        }
        
        return userID.applyPattern()
    }
    
    
    func updateUserName() {
        guard let userName = UserDefaults.standard.string(forKey: "userName") else {
            return
        }
        
        DispatchQueue.main.async {
            self.userName = userName
        }
    }
    
    
    func updateUserImage() {
        
        guard let userImage = UserDefaults.standard.string(forKey: "userImage") else {
            return
        }
        
        DispatchQueue.main.async {
            self.userImage = userImage
        }
    }
    
    
    func getUserEmail() -> String {
        
        guard let userEmail = UserDefaults.standard.string(forKey: "userEmail") else {
            return "..."
        }
        
        return userEmail
    }
    
    
    func updateDidSetupPaymentPin() {
        
        guard let info = KeychainService.getCredentials()?.info else {
            didSetupPin = false
            return
        }
        
        if info == "0" {
            didSetupPin = false
        }
        else {
            didSetupPin = true
        }
    }
    
    
    func updateCredentialsData(UserID: String?, AccessToken: String?, RefreshToken: String?, didSetupPin: String?) -> Bool {
        
        guard let credentials = KeychainService.getCredentials() else {
            print("Fail to update credentials")
            return false
        }
        
        let newCredentials = Credentials(UserID: UserID ?? credentials.UserID, AccessToken: AccessToken ?? credentials.AccessToken, RefreshToken: RefreshToken ?? credentials.RefreshToken, info: didSetupPin ?? credentials.info)
        
        KeychainService.removeCredentials()
        
        if KeychainService.saveCredentials(newCredentials) {
            return true
        }
        else {
            return false
        }
    }
    
    
    // Must be check first
    func getAccessToken() -> String? {
        guard let accessToken = KeychainService.getCredentials()?.AccessToken else {
            print("Fail to get access token")
            return nil
        }
        print("Success to get access token")
        return accessToken
    }
    
    
    func updateBalance() {
        
        guard let accessToken = getAccessToken() else {
            return
        }
        
        UserDataService.checkBalance(accessToken: accessToken) { result in
            switch result {
            case .success(let balanceData):
                
                let decoder = JSONDecoder()
                let jsonData = balanceData.data(using: .utf8)
                let balance = try! decoder.decode((Balance.self), from: jsonData!)
                DispatchQueue.main.sync {
                    if balance.balanceof != "0" {
                        guard let amountString = balance.balanceof else {
                            self.userBalance = "..."
                            return
                        }
                        let amount = Float(amountString)!
                        self.userBalance = String(format: "%.2f", amount)
                    }
                    else {
                        self.userBalance = "0.00"
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func changeUsername(newUsername: String, completion: @escaping (Bool) -> Void) {
        
        UserDataService.changeUsername(accessToken: self.getAccessToken()!, newUsername: newUsername) { result in
            
            switch result {
            case .success:
                UserDefaults.standard.set(newUsername, forKey: "userName")
                self.updateUserName()
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    func changeUserImage(newUserImage: String, completion: @escaping (Bool) -> Void) {
        
        UserDataService.changeUserImage(accessToken: self.getAccessToken()!, newUserImage: newUserImage) { result in
            
            switch result {
            case .success:
                UserDefaults.standard.set(newUserImage, forKey: "userImage")
                self.updateUserImage()
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Bool) -> Void) {
        
        PasswordService.changePassword(accessToken: self.getAccessToken()!, oldPassword: oldPassword, newPassword: newPassword) { result in
            
            switch result {
            case .success:
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    func changePaymentPin(oldPin: String, newPin: String, completion: @escaping (Bool) -> Void) {
        
        PasswordService.changePaymentPin(accessToken: self.getAccessToken()!, oldPin: oldPin, newPin: newPin) { result in
            
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
