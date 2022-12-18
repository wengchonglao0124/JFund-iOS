//
//  ChangePaymentPinView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 18/12/2022.
//

import SwiftUI

struct ChangePaymentPinView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    @State var pinStatus = "old"
    
    @State var oldPinCode = ""
    @FocusState private var oldPinKeyboardFocused: Bool
    
    @State var newPinCode = ""
    @FocusState private var newPinKeyboardFocused: Bool
    
    @State var confirmPinCode = ""
    @FocusState private var confirmPinKeyboardFocused: Bool
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    @State var invalidMessages = ""
    @State var isLoading = false
    @State var isSuccess = false
    @State var isFinish = false
    
    var body: some View {
        ZStack {
            VStack {
                if pinStatus == "old" {
                    VStack(alignment: .center, spacing: 0) {
                        Text("Enter the old pin")
                            .font(Font.custom("DMSans-Medium", size: 16))
                            .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                            .padding(.bottom, 38)
                        
                        TextField("", text: $oldPinCode)
                            .frame(width: 0, height: 0)
                            .opacity(0)
                            .focused($oldPinKeyboardFocused)
                            .limitInputTextLength(value: $oldPinCode, length: 6)
                            .keyboardType(.numberPad)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    oldPinKeyboardFocused = true
                                }
                            }
                        
                        HStack {
                            Spacer()
                            HStack(spacing: 9) {
                                ForEach(Array(oldPinCode), id: \.self) { char in
                                    Circle()
                                        .fill(Color(red: 82/255, green: 36/255, blue: 121/255))
                                        .frame(width: 12, height: 12)
                                }
                                
                                if oldPinCode.count < 6 {
                                    let loopCount = 6 - oldPinCode.count
                                    ForEach(0...loopCount-1, id: \.self) { index in
                                        Circle()
                                            .strokeBorder(Color(red: 226/255, green: 226/255, blue: 226/255), lineWidth: 2)
                                            .background(Circle().fill(Color(red: 246/255, green: 246/255, blue: 246/255)))
                                            .frame(width: 12, height: 12)
                                    }
                                }
                            }
                            .onTapGesture {
                                oldPinKeyboardFocused = true
                            }
                            Spacer()
                        }
                        .padding(.bottom, 180)
                        
                        Button {
                            print("Next: New pin")
                            oldPinKeyboardFocused = false
                            pinStatus = "new"
                            
                        } label: {
                            if oldPinCode.count < 6 {
                                Image("nextButtonInactive")
                                    .cornerRadius(8)
                            }
                            else {
                                Image("nextButton")
                                    .cornerRadius(8)
                            }
                        }
                        .disabled(oldPinCode.count < 6)
                    }
                    .padding(.top, 115)
                }
                else if pinStatus == "new" {
                    VStack(alignment: .center, spacing: 0) {
                        Text("Enter the new pin")
                            .font(Font.custom("DMSans-Medium", size: 16))
                            .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                            .padding(.bottom, 38)
                        
                        TextField("", text: $newPinCode)
                            .frame(width: 0, height: 0)
                            .opacity(0)
                            .focused($newPinKeyboardFocused)
                            .limitInputTextLength(value: $newPinCode, length: 6)
                            .keyboardType(.numberPad)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    newPinKeyboardFocused = true
                                }
                            }
                        
                        HStack {
                            Spacer()
                            HStack(spacing: 9) {
                                ForEach(Array(newPinCode), id: \.self) { char in
                                    Circle()
                                        .fill(Color(red: 82/255, green: 36/255, blue: 121/255))
                                        .frame(width: 12, height: 12)
                                }
                                
                                if newPinCode.count < 6 {
                                    let loopCount = 6 - newPinCode.count
                                    ForEach(0...loopCount-1, id: \.self) { index in
                                        Circle()
                                            .strokeBorder(Color(red: 226/255, green: 226/255, blue: 226/255), lineWidth: 2)
                                            .background(Circle().fill(Color(red: 246/255, green: 246/255, blue: 246/255)))
                                            .frame(width: 12, height: 12)
                                    }
                                }
                            }
                            .onTapGesture {
                                newPinKeyboardFocused = true
                            }
                            Spacer()
                        }
                        .padding(.bottom, 180)
                        
                        Button {
                            print("Next: Confirm pin")
                            newPinKeyboardFocused = false
                            pinStatus = "confirm"
                            
                        } label: {
                            if newPinCode.count < 6 {
                                Image("nextButtonInactive")
                                    .cornerRadius(8)
                            }
                            else {
                                Image("nextButton")
                                    .cornerRadius(8)
                            }
                        }
                        .disabled(newPinCode.count < 6)
                    }
                    .padding(.top, 115)
                }
                else if pinStatus == "confirm" {
                    VStack(alignment: .center, spacing: 0) {
                        Text("Confirm the new pin")
                            .font(Font.custom("DMSans-Medium", size: 16))
                            .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                            .padding(.bottom, 38)
                        
                        TextField("", text: $confirmPinCode)
                            .frame(width: 0, height: 0)
                            .opacity(0)
                            .focused($confirmPinKeyboardFocused)
                            .limitInputTextLength(value: $confirmPinCode, length: 6)
                            .keyboardType(.numberPad)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    confirmPinKeyboardFocused = true
                                }
                            }
                            .disabled(isLoading)
                        
                        HStack {
                            Spacer()
                            HStack(spacing: 9) {
                                ForEach(Array(confirmPinCode), id: \.self) { char in
                                    Circle()
                                        .fill(Color(red: 82/255, green: 36/255, blue: 121/255))
                                        .frame(width: 12, height: 12)
                                }
                                
                                if confirmPinCode.count < 6 {
                                    let loopCount = 6 - confirmPinCode.count
                                    ForEach(0...loopCount-1, id: \.self) { index in
                                        Circle()
                                            .strokeBorder(Color(red: 226/255, green: 226/255, blue: 226/255), lineWidth: 2)
                                            .background(Circle().fill(Color(red: 246/255, green: 246/255, blue: 246/255)))
                                            .frame(width: 12, height: 12)
                                    }
                                }
                            }
                            .onTapGesture {
                                confirmPinKeyboardFocused = true
                            }
                            Spacer()
                        }
                        .padding(.bottom, 180)
                        .disabled(isLoading)
                        
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
                        
                        Button {
                            print("Save: New pin")
                            confirmPinKeyboardFocused = false
                            invalidMessages = ""
                            
                            if !PasswordService.checkSamePasswords(password1: newPinCode, password2: confirmPinCode) {
                                invalidMessages = "Please make sure your new payment pins match."
                            }
                            else {
                                isLoading = true
                                
                                userDataVM.changePaymentPin(oldPin: oldPinCode, newPin: newPinCode) { success in
                                    if success {
                                        isSuccess = true
                                    }
                                    else {
                                        invalidMessages = "Please make sure your old payment pin is valid."
                                    }
                                    isLoading = false
                                }
                            }
                            
                        } label: {
                            if confirmPinCode.count < 6 {
                                Image("saveButtonInactive")
                                    .cornerRadius(8)
                            }
                            else {
                                Image("saveButton")
                                    .cornerRadius(8)
                            }
                        }
                        .disabled(confirmPinCode.count < 6 || isLoading)
                    }
                    .padding(.top, 115)
                }
                
                Spacer()
            }
            
            LoadingView(message: "Loading", isLoading: $isLoading)
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Change payment pin")
                        .font(Font.custom("DMSans-Bold", size: 16))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                dismiss()
            }
        }))
        .onTapGesture {
            if oldPinKeyboardFocused {
                oldPinKeyboardFocused = false
            }
            if newPinKeyboardFocused {
                newPinKeyboardFocused = false
            }
            if confirmPinKeyboardFocused {
                confirmPinKeyboardFocused = false
            }
        }
        .sheet(isPresented: $isSuccess) {
            SuccessContentView(message: "Payment pin changed!", subtitle: "Your payment pin has been reset successfully.", isPresenting: $isSuccess, finishedProcess: $isFinish)
        }
        .onChange(of: isFinish) { newValue in
            dismiss()
        }
    }
}

struct ChangePaymentPinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ChangePaymentPinView()
            }
            
            NavigationView {
                ChangePaymentPinView(pinStatus: "new")
            }
            
            NavigationView {
                ChangePaymentPinView(pinStatus: "confirm")
            }
        }
    }
}
