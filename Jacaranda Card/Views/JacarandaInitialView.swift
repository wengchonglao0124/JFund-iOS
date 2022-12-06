//
//  JacarandaInitialView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 5/12/2022.
//

import SwiftUI

struct JacarandaInitialView: View {
    
    @StateObject var authentication = Authentication()
    @StateObject var userDataVM = UserDataViewModel()
    
    @ObservedObject var networkManagerVM = NetworkManagerViewModel()
    
    var body: some View {
        
        ZStack(alignment: .top) {
            if authentication.isValidated {
                
                if userDataVM.didSetupPin {
                    JacarandaTabView()
                }
                else {
                    InitialSetupPinView(type: "initial", subtitle: "Enter a 6-digit code")
                        .environmentObject(userDataVM)
                }
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
        .onChange(of: authentication.isValidated) { newValue in
            userDataVM.updateDidSetupPaymentPin()
        }
    }
}

struct JacarandaInitialView_Previews: PreviewProvider {
    static var previews: some View {
        JacarandaInitialView()
    }
}
