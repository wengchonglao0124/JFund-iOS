//
//  PaymentService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 8/12/2022.
//

import Foundation


struct CheckPayeeIDRequestBody: Codable {
    let UserID: String
}


struct TransferRequestBody: Codable {
    let UserID: String
    let Amount: String
}


class PaymentService {
    
    static func checkPayeeID(accessToken: String, payeeID: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/checkID") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        let body = CheckPayeeIDRequestBody(UserID: payeeID)
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let generalResponse = try? JSONDecoder().decode(GeneralResponseBody.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Cannot decode from data")))
                return
            }
            
            guard generalResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "Fail to check payee ID")))
                return
            }
            
            guard let response = generalResponse.data else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            completion(.success(response))
            
        }.resume()
    }
    
    
    static func transfer(accessToken: String, payeeID: String, amount: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/transferTo") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        let body = TransferRequestBody(UserID: payeeID, Amount: amount)
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
           
            guard let generalResponse = try? JSONDecoder().decode(GeneralResponseBody.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Cannot decode from data")))
                return
            }
            print(generalResponse.msg)
            guard generalResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "Fail to transfer")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
}
