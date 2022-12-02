//
//  Jacaranda_CardApp.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 21/7/2022.
//

import SwiftUI

@main
struct Jacaranda_CardApp: App {
    
    @StateObject var authentication = Authentication()
    
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                JacarandaTabView()
                    .environmentObject(authentication)
            }
            else {
                JacarandaSignInView()
                    .environmentObject(authentication)
            }
        }
    }
}
