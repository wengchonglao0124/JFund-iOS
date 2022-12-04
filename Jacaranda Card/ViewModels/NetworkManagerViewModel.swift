//
//  NetworkManagerViewModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 5/12/2022.
//

import Foundation
import Network

class NetworkManagerViewModel: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManagerViewModel")
    
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
}
