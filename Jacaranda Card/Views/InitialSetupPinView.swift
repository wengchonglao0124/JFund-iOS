//
//  InitialSetupPinView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 6/12/2022.
//

import SwiftUI

struct InitialSetupPinView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    @FocusState private var pinKeyboardFocused: Bool
    
    var type: String
    @State var pinCode = ""
    var subtitle: String
    
    var firstPinCode = ""
    @State var invalidMessages = ""
    @State var isLoading = false
    @State var isFinished = false
    
    @State var destinationKey: String? = nil
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    if type == "initial" {
                        Text("Set up your payment pin")
                            .font(Font.custom("DMSans-Medium", size: 20))
                            .foregroundColor(Color(red: 18/255, green: 13/255, blue: 38/255))
                            .padding(.top, 70)
                            .padding(.bottom, 91)
                    }
                    else {
                        Text("Set up your payment pin")
                            .font(Font.custom("DMSans-Medium", size: 20))
                            .foregroundColor(Color(red: 18/255, green: 13/255, blue: 38/255))
                            .padding(.top, 32)
                            .padding(.bottom, 91)
                    }
                    
                    Text(subtitle)
                        .font(Font.custom("DMSans-Medium", size: 16))
                        .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                        .padding(.bottom, 38)
                    
                    TextField("", text: $pinCode)
                        .frame(width: 0, height: 0)
                        .opacity(0)
                        .focused($pinKeyboardFocused)
                        .limitInputTextLength(value: $pinCode, length: 6)
                        .keyboardType(.numberPad)
                    
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
                        .onTapGesture {
                            pinKeyboardFocused = true
                        }
                        Spacer()
                    }
                    .padding(.bottom, 180)
                    
                    // MARK: Invalid Messages Section
                    if !invalidMessages.isEmpty {
                        HStack {
                            Spacer()
                            Text(invalidMessages)
                                .font(Font.custom("DMSans-Medium", size: 10))
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .padding(.bottom, 5)
                    }
                    
                    if type == "initial" {
                        Button {
                            print("Next")
                            destinationKey = "confirmPinCode"
                            
                        } label: {
                            if pinCode.count < 6 {
                                Image("nextButtonInactive")
                                    .cornerRadius(8)
                            }
                            else {
                                Image("nextButton")
                                    .cornerRadius(8)
                            }
                        }
                        .disabled(pinCode.count < 6)
                        .background(
                            NavigationLink(destination: InitialSetupPinView(type: "confirm", subtitle: "Confirm your pin", firstPinCode: pinCode), tag: "confirmPinCode", selection: $destinationKey) {
                                EmptyView()
                            }
                        )
                    }
                    else {
                        Button {
                            invalidMessages = ""
                            
                            if !PasswordService.checkSamePasswords(password1: firstPinCode, password2: pinCode) {
                                invalidMessages = "Please make sure your pins match."
                            }
                            
                            else {
                                isLoading = true
                                
                                WebService.pinSetup(accessToken: userDataVM.getAccessToken() ?? "", pinCode: pinCode) { result in

                                    switch result {
                                    case .success:
                                        _ = userDataVM.updateCredentialsData(UserID: nil, AccessToken: nil, RefreshToken: nil, didSetupPin: "1")
                                        
                                        isFinished = true
                                        
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                        invalidMessages = "Fail to setup your payment pin."
                                    }
                                    isLoading = false
                                }
                            }
                            
                        } label: {
                            if pinCode.count < 6 {
                                Image("nextButtonInactive")
                                    .cornerRadius(8)
                            }
                            else {
                                Image("nextButton")
                                    .cornerRadius(8)
                            }
                        }
                        .disabled(pinCode.count < 6)
                    }
                    Spacer()
                }
                .disabled(isLoading)
                
                LoadingView(message: "Loading", isLoading: $isLoading)
            }
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .onTapGesture {
            pinKeyboardFocused = false
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                dismiss()
            }
        }))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                pinKeyboardFocused = true
            }
        }
        .onChange(of: isFinished) { newValue in
            DispatchQueue.main.async {
                userDataVM.didSetupPin = true
            }
        }
    }
}

struct InitialSetupPinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InitialSetupPinView(type: "initial", subtitle: "Enter a 6-digit code")
            
            NavigationView {
                InitialSetupPinView(type: "confirm", subtitle: "Confirm your pin")
            }
        }
    }
}
