//
//  ConfirmPaymentView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 7/8/2022.
//

import SwiftUI

struct ConfirmPaymentView: View {
    
    @Binding var isPresenting: Bool
    
    var title: String
    var subtitle: String
    var amount: String
    var account: String
    var buttonTitle: String
    
    @Binding var isConfirm: Bool
    
    var body: some View {
        VStack {
            if isPresenting {
                VStack {
                    Spacer()
                    VStack(spacing: 0) {
                        // MARK: Title Section
                        HStack(spacing: 0) {
                            Button {
                                isPresenting = false
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 12.4))
                                    .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                                    .padding(4.8)
                            }
                            .padding(.leading, 24)
                            .padding(.bottom, 30)

                            Text("Confirm \(title)")
                                .font(Font.custom("DMSans-Bold", size: 16))
                                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                                .padding(.leading, 28)
                                .padding(.bottom, 30)
                            Spacer()
                        }
                        .padding(.top, 25)
                        
                        // MARK: Amount Section
                        HStack {
                            Spacer()
                            VStack(spacing: 14) {
                                Text(subtitle)
                                    .font(Font.custom("DMSans-Medium", size: 16))
                                    .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                                Text("$ \(amount)")
                                    .font(Font.custom("DMSans-Medium", size: 24))
                                    .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                            }
                            Spacer()
                        }
                        .padding(.top, 23)
                        
                        // MARK: Account Section
                        HStack {
                            Text("From")
                                .font(Font.custom("DMSans-Medium", size: 16))
                                .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                                .padding(.leading, 30)
                                .padding(.top, 31)
                                .padding(.bottom, 25)
                            Spacer()
                            Text(account)
                                .font(Font.custom("DMSans-Medium", size: 16))
                                .foregroundColor(.black)
                                .padding(.trailing, 18)
                                .padding(.top, 31)
                                .padding(.bottom, 25)
                        }
                        .padding(.top, 23)
                        .padding(.bottom, 85)
    
                        // MARK: Confirm Button Section
                        Button {
                            print(buttonTitle)
                            isPresenting = false
                            isConfirm = true
                            
                        } label: {
                            HStack {
                                Spacer()
                                ZStack {
                                    Image("confirmPaymentButton")
                        
                                    Text(buttonTitle)
                                        .font(Font.custom("DMSans-Medium", size: 14))
                                        .foregroundColor(Color(red: 252/255, green: 252/255, blue: 252/255))
                                        .padding(.vertical, 12)
                                }
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 37)
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                    .cornerRadius(16)
                }
                .background(Color(red: 0, green: 0, blue: 0, opacity: 0.2))
            }
        }
        .edgesIgnoringSafeArea(.all)
        .animation(.easeInOut, value: isPresenting)
    }
}

struct ConfirmPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConfirmPaymentView(isPresenting: .constant(true), title: "details", subtitle: "Transfer", amount: "180.00", account: "Balance", buttonTitle: "Transfer", isConfirm: .constant(false))
            
            ConfirmPaymentView(isPresenting: .constant(true), title: "Top up amount", subtitle: "Top up to Balance", amount: "230.00", account: "Debit Card (5623)", buttonTitle: "Add Balance", isConfirm: .constant(false))
        }
    }
}
