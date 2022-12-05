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
    
    init() {
        updateBalance()
    }
    
    func getUserID() -> String {
        
        guard let userID = KeychainService.getCredentials()?.UserID else {
            return ""
        }
        
        return userID.applyPattern()
    }
    
    
    func updateBalance() {
        
        guard let accessToken = KeychainService.getCredentials()?.AccessToken else {
            return
        }
        
        UserDataService.checkBalance(accessToken: accessToken) { result in
            switch result {
            case .success(let balanceData):
                
                let decoder = JSONDecoder()
                let jsonData = balanceData.data(using: .utf8)
                let balance = try! decoder.decode((Balance.self), from: jsonData!)
                DispatchQueue.main.sync {
                    self.userBalance = balance.balanceof ?? "0.00"
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
