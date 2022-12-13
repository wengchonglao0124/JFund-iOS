//
//  TransferViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 8/12/2022.
//

import Foundation


struct Payee: Codable {
    var UserName: String?
    var Image: String?
}


struct TransferResponse: Codable {
    var fid: String?
}


class TransferViewModel: ObservableObject {
    
    @Published var payeeName = "..."
    @Published var payeeImage = "#74c69d"
    
    func checkPayeeID(accessToken: String, payeeID: String, completion: @escaping (Bool) -> Void) {
        
        PaymentService.checkPayeeID(accessToken: accessToken, payeeID: payeeID) { result in
            
            switch result {
            case .success(let data):
                
                let decoder = JSONDecoder()
                let jsonData = data.data(using: .utf8)
                let payee = try! decoder.decode((Payee.self), from: jsonData!)
                DispatchQueue.main.sync {
                    self.payeeName = payee.UserName ?? "Error"
                    self.payeeImage = payee.Image ?? "#74c69d"
                }
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    
    func checkBalance(balanceString: String, amountString: String) -> Bool {
        let balance = Float(balanceString) ?? 0
        let amount = Float(amountString) ?? 0
        
        if balance > 0 {
            if balance >= amount {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    
    func transfer(accessToken: String, payeeID: String, amount: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        PaymentService.transfer(accessToken: accessToken, payeeID: payeeID, amount: amount) { result in
            
            switch result {
            case .success(let data):
                
                let decoder = JSONDecoder()
                let jsonData = data.data(using: .utf8)
                let response = try! decoder.decode((TransferResponse.self), from: jsonData!)
                
                guard let fid = response.fid else {
                    completion(.failure(.custom(errorMessage: "Cannot decode for fid")))
                    return
                }
                completion(.success(fid))
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.custom(errorMessage: error.localizedDescription)))
            }
        }
    }
}
