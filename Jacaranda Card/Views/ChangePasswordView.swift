//
//  ChangePasswordView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 14/12/2022.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    @State var oldPassword = ""
    @State private var isOldPasswordSecured: Bool = true
    @FocusState private var oldPasswordKeyboardFocused: Bool
    
    @State var newPassword = ""
    @State private var isNewPasswordSecured: Bool = true
    @FocusState private var newPasswordKeyboardFocused: Bool
    
    @State var confirmNewPassword = ""
    @State private var isConfirmPasswordSecured: Bool = true
    @FocusState private var confirmNewPasswordKeyboardFocused: Bool
    
    @State var isMatchingLength = false
    @State var isMatchingFormat = false
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    @State var invalidMessages = ""
    @State var isLoading = false
    
    @State var isSuccess = false
    @State var isFinish = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Current password")
                    .foregroundColor(Color("profileSectionTitleColor"))
                    .font(Font.custom("DMSans-Medium", size: 14))
                    .padding(.bottom, 9)
                    .padding(.top, 33)
                    .padding(.leading, 16)
                
                // MARK: Current Password Input Section
                VStack {
                    HStack {
                        if isOldPasswordSecured {
                            SecureField("Please enter your current password", text: $oldPassword)
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .foregroundColor({
                                    if oldPassword.isEmpty {
                                        return Color(red: 151/255, green: 151/255, blue: 151/255)
                                    }
                                    else {
                                        return Color("FieldTextColor")
                                    }
                                }())
                                .keyboardType(.default)
                                .focused($oldPasswordKeyboardFocused)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 18)
                                .padding(.vertical, 19)
                                .disabled(isLoading)
                        }
                        else {
                            TextField("Please enter your current password", text: $oldPassword)
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .foregroundColor({
                                    if oldPassword.isEmpty {
                                        return Color(red: 151/255, green: 151/255, blue: 151/255)
                                    }
                                    else {
                                        return Color("FieldTextColor")
                                    }
                                }())
                                .keyboardType(.default)
                                .focused($oldPasswordKeyboardFocused)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 18)
                                .padding(.vertical, 19)
                                .disabled(isLoading)
                        }
                        
                        Button {
                            isOldPasswordSecured.toggle()
                        } label: {
                            if isOldPasswordSecured {
                                Image("isSecured")
                            }
                            else {
                                Image("notSecured")
                            }
                        }
                        .padding(.trailing, 15)
                    }
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                }
                .padding(.bottom, 24)
                .onTapGesture {
                    oldPasswordKeyboardFocused = true
                }
                
                Text("New password")
                    .foregroundColor(Color("profileSectionTitleColor"))
                    .font(Font.custom("DMSans-Medium", size: 14))
                    .padding(.bottom, 9)
                    .padding(.leading, 16)
                
                // MARK: New Password Input Section
                VStack {
                    HStack {
                        if isNewPasswordSecured {
                            SecureField("Please enter your new password", text: $newPassword)
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .foregroundColor({
                                    if newPassword.isEmpty {
                                        return Color(red: 151/255, green: 151/255, blue: 151/255)
                                    }
                                    else {
                                        return Color("FieldTextColor")
                                    }
                                }())
                                .keyboardType(.default)
                                .focused($newPasswordKeyboardFocused)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 18)
                                .padding(.vertical, 19)
                                .disabled(isLoading)
                        }
                        else {
                            TextField("Please enter your new password", text: $newPassword)
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .foregroundColor({
                                    if newPassword.isEmpty {
                                        return Color(red: 151/255, green: 151/255, blue: 151/255)
                                    }
                                    else {
                                        return Color("FieldTextColor")
                                    }
                                }())
                                .keyboardType(.default)
                                .focused($newPasswordKeyboardFocused)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 18)
                                .padding(.vertical, 19)
                                .disabled(isLoading)
                        }
                        
                        Button {
                            isNewPasswordSecured.toggle()
                        } label: {
                            if isNewPasswordSecured {
                                Image("isSecured")
                            }
                            else {
                                Image("notSecured")
                            }
                        }
                        .padding(.trailing, 15)
                    }
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                }
                .onTapGesture {
                    newPasswordKeyboardFocused = true
                }
                
                // MARK: Check New Password Section
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 6) {
                        Image(isMatchingLength ? "passwordCorrect" :  "passwordCorrectInactive")
                        Text("6-20 characters")
                            .foregroundColor(isMatchingLength ? Color(red: 37/255, green: 194/255, blue: 110/255) : Color(red: 196/255, green: 196/255, blue: 196/255))
                            .font(Font.custom("DMSans-Medium", size: 12))
                        Spacer()
                    }
                    
                    HStack(spacing: 6) {
                        Image(isMatchingFormat ? "passwordCorrect" :  "passwordCorrectInactive")
                        Text("Consists numbers, uppercase & lowercase letters")
                            .foregroundColor(isMatchingFormat ? Color(red: 37/255, green: 194/255, blue: 110/255) : Color(red: 196/255, green: 196/255, blue: 196/255))
                            .font(Font.custom("DMSans-Medium", size: 12))
                        Spacer()
                    }
                }
                .padding(.leading, 18)
                .padding(.vertical, 15)
                .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                
                // MARK: Confirm New Password Input Section
                VStack {
                    HStack {
                        if isConfirmPasswordSecured {
                            SecureField("Confirm new password", text: $confirmNewPassword)
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .foregroundColor({
                                    if confirmNewPassword.isEmpty {
                                        return Color(red: 151/255, green: 151/255, blue: 151/255)
                                    }
                                    else {
                                        return Color("FieldTextColor")
                                    }
                                }())
                                .keyboardType(.default)
                                .focused($confirmNewPasswordKeyboardFocused)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 18)
                                .padding(.vertical, 19)
                                .disabled(isLoading)
                        }
                        else {
                            TextField("Confirm new password", text: $confirmNewPassword)
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .foregroundColor({
                                    if confirmNewPassword.isEmpty {
                                        return Color(red: 151/255, green: 151/255, blue: 151/255)
                                    }
                                    else {
                                        return Color("FieldTextColor")
                                    }
                                }())
                                .keyboardType(.default)
                                .focused($confirmNewPasswordKeyboardFocused)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 18)
                                .padding(.vertical, 19)
                                .disabled(isLoading)
                        }
                        
                        Button {
                            isConfirmPasswordSecured.toggle()
                        } label: {
                            if isConfirmPasswordSecured {
                                Image("isSecured")
                            }
                            else {
                                Image("notSecured")
                            }
                        }
                        .padding(.trailing, 15)
                    }
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                }
                .padding(.bottom, 33)
                .onTapGesture {
                    confirmNewPasswordKeyboardFocused = true
                }
                
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
                
                // MARK: Save New Password Button Section
                HStack {
                    Spacer()
                    
                    Button {
                        
                        if oldPasswordKeyboardFocused {
                            oldPasswordKeyboardFocused = false
                        }
                        if newPasswordKeyboardFocused {
                            newPasswordKeyboardFocused = false
                        }
                        if confirmNewPasswordKeyboardFocused {
                            confirmNewPasswordKeyboardFocused = false
                        }
                        
                        print("Change password")
                        isLoading = true
                        invalidMessages = ""
                        
                        if !PasswordService.checkSamePasswords(password1: newPassword, password2: confirmNewPassword) {
                            
                            print("Please make sure your new passwords match.")
                            invalidMessages = "Please make sure your new passwords match."
                            isLoading = false
                        }
                        else {
                            userDataVM.changePassword(oldPassword: oldPassword, newPassword: newPassword) { success in
                                
                                if success {
                                    isSuccess = true
                                }
                                else {
                                    invalidMessages = "Please make sure your current password is correct."
                                }
                                isLoading = false
                            }
                        }
                        
                    } label: {
                        if oldPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty || !isMatchingLength || !isMatchingFormat {
                            Image("saveButtonInactive")
                        }
                        else {
                            Image("saveButton")
                        }
                    }
                    .disabled(oldPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty || isLoading || !isMatchingLength || !isMatchingFormat)
                    Spacer()
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
                    Text("Change password")
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
            if oldPasswordKeyboardFocused {
                oldPasswordKeyboardFocused = false
            }
            if newPasswordKeyboardFocused {
                newPasswordKeyboardFocused = false
            }
            if confirmNewPasswordKeyboardFocused {
                confirmNewPasswordKeyboardFocused = false
            }
        }
        .onSubmit {
            if oldPasswordKeyboardFocused {
                oldPasswordKeyboardFocused = false
                newPasswordKeyboardFocused = true
                
            } else if newPasswordKeyboardFocused {
                newPasswordKeyboardFocused = false
                confirmNewPasswordKeyboardFocused = true
                
            } else if confirmNewPasswordKeyboardFocused {
                confirmNewPasswordKeyboardFocused = false
            }
        }
        .onChange(of: newPassword) { newValue in
            if PasswordService.checkPasswordLength(password: newPassword) {
                isMatchingLength = true
            }
            else {
                isMatchingLength = false
            }
            
            if PasswordService.checkPasswordFormat(password: newPassword) {
                isMatchingFormat = true
            }
            else {
                isMatchingFormat = false
            }
        }
        .sheet(isPresented: $isSuccess) {
            SuccessContentView(message: "Password Changed!", subtitle: "Your password has been reset successfully.", isPresenting: $isSuccess, finishedProcess: $isFinish)
        }
        .onChange(of: isFinish) { newValue in
            dismiss()
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChangePasswordView()
        }
    }
}
