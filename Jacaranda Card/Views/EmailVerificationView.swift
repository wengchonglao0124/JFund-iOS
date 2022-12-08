//
//  EmailVerificationView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 5/12/2022.
//

import SwiftUI

struct EmailVerificationView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    var navigationTitle: String
    var email: String
    var serverLocation: String
    
    @FocusState private var codeKeyboardFocused: Bool
    
    @State var verificationCode = ""
    
    @State var inputBoxColor = Color(red: 235/255, green: 235/255, blue: 245/255, opacity: 0.2)
    @State var inputBoxBorder = Color(red: 196/255, green: 196/255, blue: 196/255)
    
    @State var isLoading = false
    @State var isVerified = false
    @Binding var isFinished: Bool
    
    var successMessage = ""
    var successSubtitle = ""
    
    // Timer: 1 minutes
    @State private var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Please enter the verification code")
                        .font(Font.custom("DMSans-Medium", size: 16))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                        .padding(.top, 40)
                        .padding(.bottom, 8)
                    
                    Text("We have sent a verification code to your registered email")
                        .font(Font.custom("DMSans-Medium", size: 12))
                        .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                        .padding(.bottom, 64)
                }
                .padding(.leading, 28)
                
                TextField("", text: $verificationCode)
                    .frame(width: 0, height: 0)
                    .opacity(0)
                    .focused($codeKeyboardFocused)
                    .limitInputTextLength(value: $verificationCode, length: 6)
                    .keyboardType(.numberPad)
                
                HStack(spacing: 15) {
                    Spacer()
                    ForEach(Array(verificationCode), id: \.self) { char in
                        Text(String(char))
                            .font(Font.custom("DMSans-Medium", size: 20))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(inputBoxColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(inputBoxBorder, lineWidth: 1)
                            )
                            .cornerRadius(8)
                            .onTapGesture {
                                codeKeyboardFocused = true
                            }
                    }
                    if verificationCode.count < 6 {
                        let loopCount = 6 - verificationCode.count
                        ForEach(0...loopCount-1, id: \.self) { index in
                            Text("")
                                .font(Font.custom("DMSans-Medium", size: 20))
                                .foregroundColor(.black)
                                .frame(width: 40, height: 40)
                                .background(Color(red: 235/255, green: 235/255, blue: 245/255, opacity: 0.2))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 196/255, green: 196/255, blue: 196/255), lineWidth: 1)
                                )
                                .cornerRadius(8)
                                .onTapGesture {
                                    codeKeyboardFocused = true
                                }
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 42)
                
                HStack {
                    Spacer()
                    Text("Didn’t receive the code?")
                        .font(Font.custom("DMSans-Medium", size: 12))
                        .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                        .padding(.trailing, 2)
                    
                    Button {
                        if timeRemaining < 0 {
                            print("Resend")
                            
                            // if success
                            timeRemaining = 60
                        }
                        
                    } label: {
                        if timeRemaining >= 0 {
                            if timeRemaining == 60 {
                                Text("01:00")
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .foregroundColor(Color(red: 25/255, green: 73/255, blue: 216/255))
                                .underline(true)
                            }
                            else if timeRemaining >= 10 {
                                Text("00:\(timeRemaining)")
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .foregroundColor(Color(red: 25/255, green: 73/255, blue: 216/255))
                                .underline(true)
                            }
                            else {
                                Text("00:0\(timeRemaining)")
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .foregroundColor(Color(red: 25/255, green: 73/255, blue: 216/255))
                                .underline(true)
                            }
                        }
                        else {
                            Text("Resend")
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .foregroundColor(Color(red: 82/255, green: 36/255, blue: 121/255))
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .disabled(isLoading)
            
            LoadingView(message: "Loading", isLoading: $isLoading)
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(navigationTitle)
                        .font(Font.custom("DMSans-Bold", size: 16))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            codeKeyboardFocused = false
            dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .onTapGesture {
            codeKeyboardFocused = false
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                codeKeyboardFocused = false
                dismiss()
            }
        }))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                codeKeyboardFocused = true
            }
        }
        .sheet(isPresented: $isVerified) {
            SuccessContentView(message: "You have created your account sucessfully!", subtitle: "", isPresenting: $isVerified, finishedProcess: $isFinished)
        }
        .onChange(of: verificationCode) { newValue in
            if verificationCode.count == 6 {
                
                isLoading = true
                
                WebService.emailVerification(email: email, verificationCode: verificationCode, serverLocation: serverLocation) { result in
                    
                    switch result {
                    case .success:
                        // Correct Color
                        inputBoxColor = Color(red: 37/255, green: 194/255, blue: 110/255, opacity: 0.1)
                        inputBoxBorder = Color(red: 37/255, green: 194/255, blue: 110/255)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isVerified = true
                        }
                        
                    case .failure:
                        // Incorrect Color
                        inputBoxColor = Color(red: 252/255, green: 225/255, blue: 223/255)
                        inputBoxBorder = Color(red: 255/255, green: 85/255, blue: 74/255)
                        codeKeyboardFocused = true
                    }
                    isLoading = false
                }
            }
            else {
                inputBoxColor = Color(red: 235/255, green: 235/255, blue: 245/255, opacity: 0.2)
                inputBoxBorder = Color(red: 196/255, green: 196/255, blue: 196/255)
            }
        }
        .onChange(of: isFinished) { newValue in
            dismiss()
        }
        .onReceive(timer) { time in
            if timeRemaining >= 0 {
                timeRemaining -= 1
            }
        }
    }
}

struct EmailVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            NavigationView {
                EmailVerificationView(navigationTitle: "", email: "", serverLocation: "", isFinished: .constant(false))
            }
            
            NavigationView {
                EmailVerificationView(navigationTitle: "Forgot password", email: "", serverLocation: "", isFinished: .constant(false))
            }
        }
    }
}
