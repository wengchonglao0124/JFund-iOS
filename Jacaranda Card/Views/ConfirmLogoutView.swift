//
//  ConfirmLogoutView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 2/12/2022.
//

import SwiftUI

struct ConfirmLogoutView: View {
    
    @Binding var isPresenting: Bool
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        if isPresenting {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    VStack(spacing: 32) {
                        Text("Are you sure to log out?")
                            .font(Font.custom("DMSans-Bold", size: 18))
                            .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                            .padding(.top, 62)
                        
                        HStack(spacing: 0) {
                            Button {
                                print("Cancel: Are you sure to log out?")
                                isPresenting = false
                                
                            } label: {
                                Text("Cancel")
                                    .font(Font.custom("DMSans-Medium", size: 14))
                                    .foregroundColor(Color(red: 122/255, green: 126/255, blue: 128/255))
                            }
                            .padding(.leading, 67)
                            
                            Spacer()
                            
                            Button {
                                print("Yes: Are you sure to log out?")
                                isPresenting = false
                                
                                UserDefaults.standard.removeObject(forKey: "userName")
                                UserDefaults.standard.removeObject(forKey: "userImage")
                                UserDefaults.standard.removeObject(forKey: "lastActivityDate")
                                UserDefaults.standard.removeObject(forKey: "lastActivityReceipt")
                                
                                authentication.updateValidation(success: false)
                                KeychainService.removeCredentials()
                                
                            } label: {
                                Text("Log out")
                                    .font(Font.custom("DMSans-Medium", size: 14))
                                    .foregroundColor(Color(red: 252/255, green: 252/255, blue: 252/255))
                                    .frame(width: 125, height: 44)
                                    .background(Color(red: 191/255, green: 61/255, blue: 53/255))
                                    .cornerRadius(8)
                            }
                            .padding(.trailing, 33)
                        }
                        .padding(.bottom, 33)
                    }
                    .frame(width: 350, height: 196)
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                    .cornerRadius(16)
                    
                    Spacer()
                }
                Spacer()
            }
            .background(Color(red: 0, green: 0, blue: 0, opacity: 0.2))
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut, value: isPresenting)
        }
    }
}

struct ConfirmLogoutView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmLogoutView(isPresenting: .constant(true))
    }
}
