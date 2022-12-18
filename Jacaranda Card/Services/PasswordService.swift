//
//  PasswordService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 1/12/2022.
//

import Foundation


struct ChangePasswordRequestBody: Codable {
    let oldPswd: String
    let newPswd: String
}


struct ForgotPasswordRequestBody: Codable {
    let email: String
    let password: String
}


struct ChangePaymentPinRequestBody: Codable {
    let oldPin: String
    let newPin: String
}


struct ForgotPaymentPinRequestBody: Codable {
    let pin: String
}


class PasswordService {
    
    static func checkSamePasswords(password1: String, password2: String) -> Bool {
        return password1 == password2
    }
    
    
    static func checkPasswordLength(password: String) -> Bool {
        
        if password.count >= 6 && password.count <= 20 {
            return true
        }
        else {
            return false
        }
    }
    
    
    static func checkPasswordFormat(password: String) -> Bool {
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalResult = texttest.evaluate(with: password)
        
        let lowerLetterRegEx  = ".*[a-z]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", lowerLetterRegEx)
        let lowerResult = texttest1.evaluate(with: password)

        let numberRegEx  = ".*[0-9]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberResult = texttest2.evaluate(with: password)

        return capitalResult && lowerResult && numberResult
    }
    
    
    static func changePassword(accessToken: String, oldPassword: String, newPassword: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/changePswd") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        let body = ChangePasswordRequestBody(oldPswd: oldPassword, newPswd: newPassword)
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
                completion(.failure(.custom(errorMessage: "Fail to change password")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
    
    
    static func forgotPassword(email: String, newPassword: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/setPswd") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ForgotPasswordRequestBody(email: email, password: newPassword)
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
                completion(.failure(.custom(errorMessage: "Fail to request forgot password")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
    
    
    static func changePaymentPin(accessToken: String, oldPin: String, newPin: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/changePin") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        let body = ChangePaymentPinRequestBody(oldPin: oldPin, newPin: newPin)
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
                completion(.failure(.custom(errorMessage: "Fail to change payment pin")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
    
    
    static func forgotPaymentPin(accessToken: String, newPin: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/setPin") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        let body = ForgotPaymentPinRequestBody(pin: newPin)
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
                completion(.failure(.custom(errorMessage: "Fail to request forgot payment pin")))
                return
            }
            
            completion(.success(""))
            
        }.resume()
    }
}
