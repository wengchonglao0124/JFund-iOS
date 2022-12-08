//
//  TransferViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 8/12/2022.
//

import Foundation


struct Payee: Codable {
    var UserName: String?
}


class TransferViewModel: ObservableObject {
    
    @Published var payeeName = ""
    var task: URLSessionDataTask? = nil
    
    func checkPayeeID(accessToken: String, payeeID: String, completion: @escaping (Bool) -> Void) {
        
        PaymentService.checkPayeeID(accessToken: accessToken, payeeID: payeeID) { result in
            
            switch result {
            case .success(let data):
                
                let decoder = JSONDecoder()
                let jsonData = data.data(using: .utf8)
                let payee = try! decoder.decode((Payee.self), from: jsonData!)
                DispatchQueue.main.sync {
                    self.payeeName = payee.UserName ?? "Error"
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
    
    
    func transfer(accessToken: String, payeeID: String, amount: String, completion: @escaping (Bool) -> Void) {
        
        let task = PaymentService.transfer(accessToken: accessToken, payeeID: payeeID, amount: amount) { result in
            
            switch result {
            case .success:
                completion(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
        self.task = task
    }
    
    
    func cancel() {
        guard let task = task else {
            print("Fail to cancel task")
            return
        }
        task.cancel()
        print("Successful to cancel task")
    }
}
