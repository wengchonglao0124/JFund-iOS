//
//  KeychainService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 5/12/2022.
//

import Foundation
import SwiftKeychainWrapper

enum KeychainService {
    static let key = "credentials"
    
    static func getCredentials() -> Credentials? {
        if let myCredentialsString = KeychainWrapper.standard.string(forKey: Self.key) {
            return Credentials.decode(myCredentialsString)
        }
        else {
            return nil
        }
    }
    
    static func saveCredentials(_ credentials: Credentials) -> Bool {
        if KeychainWrapper.standard.set(credentials.encoded(), forKey: Self.key) {
            return true
        }
        else {
            print("Fail to save Credentials")
            return false
        }
    }
    
    static func removeCredentials() {
        KeychainWrapper.standard.removeAllKeys()
    }
}
