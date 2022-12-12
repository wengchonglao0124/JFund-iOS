//
//  UserData.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 13/12/2022.
//

import Foundation

struct UserData: Codable {
    
    var UserName: String
    var image: String
    
    static func decode(_ userDataString: String) -> UserData {
        let decoder = JSONDecoder()
        let jsonData = userDataString.data(using: .utf8)
        return try! decoder.decode((UserData.self), from: jsonData!)
    }
}
