//
//  UserDataService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 5/12/2022.
//

import Foundation


enum UserDataError: Error {
    case invalidData
    case custom(errorMessage: String)
}


struct UserDataResponseBody: Codable {
    let code: String?
    let msg: String?
    let data: String?
}


class UserDataService {
    
    static func checkBalance(accessToken: String, completion: @escaping (Result<String, UserDataError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/balanceOf") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let userDataResponse = try? JSONDecoder().decode(UserDataResponseBody.self, from: data) else {
                completion(.failure(.invalidData))
                return
            }
            
            guard userDataResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "Fail to get balance")))
                return
            }
            
            guard let response = userDataResponse.data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(response))
            
        }.resume()
    }
}

