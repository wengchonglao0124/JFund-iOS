//
//  JacarandaInitialView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 5/12/2022.
//

import SwiftUI

struct JacarandaInitialView: View {
    
    @StateObject var authentication = Authentication()
    
    @ObservedObject var networkManagerVM = NetworkManagerViewModel()
    
    var body: some View {
        
        ZStack(alignment: .top) {
            if authentication.isValidated {
                JacarandaTabView()
            }
            else {
                JacarandaSignInView()
            }
            
            if !networkManagerVM.isConnected {
                Text("Network Connection Error")
                    .foregroundColor(.red)
                    .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0))
            }
        }
        .environmentObject(authentication)
    }
}

struct JacarandaInitialView_Previews: PreviewProvider {
    static var previews: some View {
        JacarandaInitialView()
    }
}
