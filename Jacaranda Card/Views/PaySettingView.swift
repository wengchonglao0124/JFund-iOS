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
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
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
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
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
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
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
        Group {
            PaySettingView(isPresentingSettingView: .constant(true))
            
            NavigationView {
                JacarandaPayView(isPresentingSettingView: true, username: "Lilyxoxo", carID: "1234 5678 3657 5623")
            }
        }
    }
}
