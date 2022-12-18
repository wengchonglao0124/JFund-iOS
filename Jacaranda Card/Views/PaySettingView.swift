//
//  PaySettingView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 31/7/2022.
//

import SwiftUI

struct PaySettingView: View {
    
    @Binding var isPresentingSettingView: Bool
    
    var body: some View {
        VStack {
            if isPresentingSettingView {
                VStack {
                    Spacer()
                    VStack(spacing: 0) {
                        Button {
                            print("Payment Setting")
                        } label: {
                            HStack {
                                Spacer()
                                Text("Payment Setting")
                                    .font(Font.custom("DMSans-Medium", size: 16))
                                    .foregroundColor(.black)
                                    .padding(.vertical, 20)
                                Spacer()
                            }
                        }
                        Divider()
                        Button {
                            print("Renew QR Code")
                        } label: {
                            HStack {
                                Spacer()
                                Text("Renew QR Code")
                                    .font(Font.custom("DMSans-Medium", size: 16))
                                    .foregroundColor(.black)
                                    .padding(.vertical, 20)
                                Spacer()
                            }
                        }
                        Divider()
                        Button {
                            print("Help & Support")
                        } label: {
                            HStack {
                                Spacer()
                                Text("Help & Support")
                                    .font(Font.custom("DMSans-Medium", size: 16))
                                    .foregroundColor(.black)
                                    .padding(.vertical, 20)
                                Spacer()
                            }
                        }
                    }
                    .padding(.bottom, 34)
                    .background(.white)
                    .cornerRadius(16)
                }
                .background(Color(red: 63/255, green: 51/255, blue: 86/255, opacity: 0.25))
                .onTapGesture {
                    isPresentingSettingView = false
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .animation(.easeInOut, value: isPresentingSettingView)
    }
}

struct PaySettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        let data = "{\"image\":\"#a2d2ff\",\"UserName\":\"billylao\",\"RefreshToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzEzMzk3MDEsImp0aSI6InJlZnJlc2hUb2tlbiJ9.KJSENeGG5vaCMfWh01irNlsUPgvU4jd0_2vB_Xlnwps\",\"UserID\":\"4468674852519615\",\"AccessToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzA4MjEzMDEsImp0aSI6ImFjY2Vzc1Rva2VuIn0.4Nj-KpJUznS86VSHaRn4NlgCZVJiqoe6DT-7IkKAk0M\",\"info\":\"1\"}"
        
        let credentials = Credentials.decode(data)
        let isSuccess = KeychainService.saveCredentials(credentials)
        
        if isSuccess {
            let userDataVM = UserDataViewModel()
            
            let userData = UserData.decode(data)
        
            Group {
                PaySettingView(isPresentingSettingView: .constant(true))
                
                NavigationView {
                    JacarandaPayView(isPresentingSettingView: true)
                }
                .environmentObject(userDataVM)
                .onAppear(perform: {
                    UserDefaults.standard.set(userData.UserName, forKey: "userName")
                })
            }
        }
    }
}
