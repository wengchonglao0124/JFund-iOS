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


struct ChangeUsernameRequestBody: Codable {
    let username: String
}


struct ChangeUserImageRequestBody: Codable {
    let images: String
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
    
    
    static func changeUsername(accessToken: String, newUsername: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/changeUsername") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        let body = ChangeUsernameRequestBody(username: newUsername)
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let dataResponse = try? JSONDecoder().decode(GeneralResponseBody.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Cannot decode from data")))
                return
            }
            
            guard dataResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "Fail to change username")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
    
    
    static func changeUserImage(accessToken: String, newUserImage: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/updateImage") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        let body = ChangeUserImageRequestBody(images: newUserImage)
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let dataResponse = try? JSONDecoder().decode(GeneralResponseBody.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Cannot decode from data")))
                return
            }
            
            guard dataResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "Fail to change user image")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
}

