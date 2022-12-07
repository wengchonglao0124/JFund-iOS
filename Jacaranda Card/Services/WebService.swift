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


enum SignUpError: Error {
    case invalidSignUp
    case custom(errorMessage: String)
}


struct SignUpRequestBody: Codable {
    let email: String
    let password: String
    let username: String
}


struct SignUpResponseBody: Codable {
    let code: String?
    let msg: String?
    let data: [String: String]?
}


enum GeneralError: Error {
    case custom(errorMessage: String)
}


struct EmailVerificationRequestBody: Codable {
    let email: String
    let code: String
}


struct GeneralResponseBody: Codable {
    let code: String?
    let msg: String?
    let data: String?
}


struct PinCodeRequestBody: Codable {
    let pin: String
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
            
            guard loginResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "Fail to Login")))
                return
            }
            
            guard let response = loginResponse.data else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(response))
            
        }.resume()
    }
    
    
    static func signUp(email: String, password: String, username: String, completion: @escaping (Result<String, SignUpError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/email") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = SignUpRequestBody(email: email, password: password, username: username)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
           
            guard let signUpResponse = try? JSONDecoder().decode(SignUpResponseBody.self, from: data) else {
                completion(.failure(.invalidSignUp))
                return
            }
            
            guard signUpResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "This account already exists")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
    
    
    static func emailVerification(email: String, verificationCode: String, serverLocation: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc\(serverLocation)") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = EmailVerificationRequestBody(email: email, code: verificationCode)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
           
            guard let emailVerificationResponse = try? JSONDecoder().decode(GeneralResponseBody.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Fail to verified")))
                return
            }
            
            guard emailVerificationResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "Fail to verified")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
    
    
    static func pinSetup(accessToken: String, pinCode: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/info") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = PinCodeRequestBody(pin: pinCode)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
           
            guard let pinCodeResponse = try? JSONDecoder().decode(GeneralResponseBody.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Fail to setup pin")))
                return
            }
            
            guard pinCodeResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "Fail to setup pin")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
}
