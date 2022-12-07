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
    
    init() {
        updateDidSetupPaymentPin()
    }
    
    func getUserID() -> String {
        
        guard let userID = KeychainService.getCredentials()?.UserID else {
            return ""
        }
        
        return userID.applyPattern()
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
            return nil
        }
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
                        self.userBalance = balance.balanceof ?? "0.00"
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
}
