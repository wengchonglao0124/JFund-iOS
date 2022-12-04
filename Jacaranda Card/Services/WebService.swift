//
//  WebService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 4/12/2022.
//

import Foundation


enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}


struct LoginRequestBody: Codable {
    let email: String
    let password: String
}


struct LoginResponseBody: Codable {
    let code: String?
    let msg: String?
    let data: String?
}


class WebService {
    
    static func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponseBody.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let response = loginResponse.data else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(response))
            
        }.resume()
    }
}
