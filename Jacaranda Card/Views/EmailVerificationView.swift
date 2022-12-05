//
//  EmailVerificationView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 5/12/2022.
//

import SwiftUI

struct EmailVerificationView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var navigationTitle: String
    @FocusState private var codeKeyboardFocused: Bool
    
    @State var verificationCode = ""
    
    var body: some View {
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
                    print("Resend")
                    
                } label: {
                    Text("Resend")
                        .font(Font.custom("DMSans-Medium", size: 12))
                        .foregroundColor(Color(red: 82/255, green: 36/255, blue: 121/255))
                }
                Spacer()
            }
            Spacer()
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
            self.mode.wrappedValue.dismiss()
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
                self.mode.wrappedValue.dismiss()
            }
        }))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                codeKeyboardFocused = true
            }
        }
    }
}

struct EmailVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                EmailVerificationView(navigationTitle: "")
            }
            
            NavigationView {
                EmailVerificationView(navigationTitle: "Forgot password")
            }
        }
    }
}
