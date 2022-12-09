//
//  ConfirmPaymentPinView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 8/12/2022.
//

import SwiftUI

struct ConfirmPaymentPinView: View {
    
    var accessToken: String
    @Binding var isPresenting: Bool
    
    @State var pinCode = ""
    
    @State var invalidMessages = ""
    @State var isLoading = false
    @State var isSuccess = false
    @Binding var isCancel: Bool
    @Binding var isFinish: Bool
    
    var fid: String
    var serverAddress: String
    
    // Timer: 90 seconds
    @State private var timeRemaining = 90
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                                isCancel = true
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 12.4))
                                    .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                                    .padding(4.8)
                            }
                            .padding(.leading, 24)
                            .padding(.bottom, 30)
                            .disabled(isLoading)

                            Text("Please enter the payment pin")
                                .font(Font.custom("DMSans-Bold", size: 16))
                                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                                .padding(.leading, 28)
                                .padding(.bottom, 30)
                            Spacer()
                        }
                        .padding(.top, 25)
                        .padding(.bottom, 65)
                        
                        // MARK: Subtitle Section
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 82/255, green: 32/255, blue: 121/255)))
                                .padding(.bottom, 5)
                        }
                        
                        HStack {
                            Spacer()
                            VStack(spacing: 14) {
                                Text("Enter the pin")
                                    .font(Font.custom("DMSans-Medium", size: 16))
                                    .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                            }
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            HStack(spacing: 9) {
                                ForEach(Array(pinCode), id: \.self) { char in
                                    Circle()
                                        .fill(Color(red: 82/255, green: 36/255, blue: 121/255))
                                        .frame(width: 12, height: 12)
                                }
                                
                                if pinCode.count < 6 {
                                    let loopCount = 6 - pinCode.count
                                    ForEach(0...loopCount-1, id: \.self) { index in
                                        Circle()
                                            .strokeBorder(Color(red: 226/255, green: 226/255, blue: 226/255), lineWidth: 2)
                                            .background(Circle().fill(Color(red: 246/255, green: 246/255, blue: 246/255)))
                                            .frame(width: 12, height: 12)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 35)
                        .padding(.bottom, 115)
                        
                        // MARK: Invalid Messages Section
                        if !invalidMessages.isEmpty {
                            HStack {
                                Spacer()
                                Text(invalidMessages)
                                    .font(Font.custom("DMSans-Medium", size: 10))
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .padding(.vertical, 10)
                        }
                        
                        CustomNumberPadView(password: $pinCode)
                            .disabled(isLoading)
                    }
                    .padding(.bottom, 37)
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                    .cornerRadius(16)
                }
                .background(Color(red: 0, green: 0, blue: 0, opacity: 0.2))
                .onChange(of: pinCode) { newValue in
                    
                    if pinCode.count == 6 {
                        invalidMessages = ""
                        isLoading = true
                        
                        PaymentService.verifyPin(accessToken: accessToken, pin: pinCode, fid: fid, serverAddress: serverAddress) { result in
                            
                            switch result {
                            case .success(_):
                                isSuccess = true
                                
                            case .failure(let error):
                                invalidMessages = "Invalid pin, please try again."
                                print(error.localizedDescription)
                            }
                            isLoading = false
                            pinCode = ""
                        }
                    }
                }
                .onChange(of: isSuccess) { newValue in
                    isPresenting = false
                    isFinish = true
                }
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                    else {
                        isCancel = true
                        isPresenting = false
                    }
                }
                .onAppear(perform: {
                    pinCode = ""
                    invalidMessages = ""
                    timeRemaining = 90
                })
            }
        }
        .edgesIgnoringSafeArea(.all)
        .animation(.easeInOut, value: isPresenting)
    }
}

struct ConfirmPaymentPinView_Previews: PreviewProvider {
    static var previews: some View {
        
        ConfirmPaymentPinView(accessToken: "", isPresenting: .constant(true), isCancel: .constant(false), isFinish: .constant(true), fid: "", serverAddress: "")
    }
}
