//
//  PayViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 3/1/2023.
//

import Foundation

class PayViewModel {
    
    let stream: WebSocketStream? = {
        
        guard let userID = KeychainService.getCredentials()?.UserID else {
            return nil
        }
        
        return WebSocketStream(url: "ws://lycyy.cc:8080/websocket/%7B\(userID)%7D")
    }()
    
}
