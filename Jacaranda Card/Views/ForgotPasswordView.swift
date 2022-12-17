//
//  ForgotPasswordView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 29/11/2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    @FocusState private var emailKeyboardFocused: Bool
    
    @State var email = ""
    
    @State var isPresentingEmail = true
    
    @State var newPassword = ""
    @State private var isNewPasswordSecured: Bool = true
    @FocusState private var newPasswordKeyboardFocused: Bool
    
    @State var confirmNewPassword = ""
    @State private var isConfirmPasswordSecured: Bool = true
    @FocusState private var confirmNewPasswordKeyboardFocused: Bool
    
    @State var isMatchingLength = false
    @State var isMatchingFormat = false
    
    var forgotPasswordVM = ForgotPasswordViewModel()
    
    @State var invalidMessages = ""
    @State var isLoading = false
    
    @State var destinationKey: String? = nil
    @State var isFinish = false
    
    var body: some View {
        ZStack {
            VStack {
                if isPresentingEmail {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Forgot password?")
                            .font(Font.custom("DMSans-Medium", size: 20))
                            .foregroundColor(Color(red: 18/255, green: 13/255, blue: 32/255))
                            .padding(.top, 31)
                            .padding(.bottom, 14)
                        
                        Text("Enter your registered email.")
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                            .padding(.bottom, 38)
                        
                        // MARK: Email Input Section
                        VStack {
                            HStack(spacing: 11) {
                                Image("emailLogo")
                                
                                TextField("Email", text: $email)
                                    .font(Font.custom("DMSans-Medium", size: 14))
                                    .foregroundColor({
                                        if email.isEmpty {
                                            return Color("PlaceholderTextColor")
                                        }
                                        else {
                                            return Color("FieldTextColor")
                                        }
                                    }())
                                    .keyboardType(.emailAddress)
                                    .disableAutocorrection(true)
                                    .textInputAutocapitalization(.never)
                                    .focused($emailKeyboardFocused)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .background(Color("FieldBgColor"))
                        }
                        .cornerRadius(5)
                        .padding(.bottom, 43)
                        .onTapGesture {
                            emailKeyboardFocused = true
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                print("Next: Forgot password")
                                emailKeyboardFocused = false
                                isPresentingEmail = false
                                
                            } label: {
                                if email.isEmpty {
                                    Image("nextButtonInactive")
                                }
                                else {
                                    Image("nextButton")
                                }
                            }
                            .disabled(email.isEmpty)
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 27)
                    .onSubmit {
                        if emailKeyboardFocused {
                            emailKeyboardFocused = false
                        }
                    }
                }
                else {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Reset a new password")
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                            .padding(.top, 33)
                            .padding(.bottom, 9)
                            .padding(.leading, 18)
                        
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
                                        .disableAutocorrection(true)
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
                                        .disableAutocorrection(true)
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
                                        .disableAutocorrection(true)
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
                                        .disableAutocorrection(true)
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
                        .padding(.bottom, 64)
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
                        
                        // MARK: Request Forgot Password Button Section
                        HStack {
                            Spacer()
                            Button {
                                if newPasswordKeyboardFocused {
                                    newPasswordKeyboardFocused = false
                                }
                                if confirmNewPasswordKeyboardFocused {
                                    confirmNewPasswordKeyboardFocused = false
                                }
                                
                                invalidMessages = ""
                                
                                if !PasswordService.checkSamePasswords(password1: newPassword, password2: confirmNewPassword) {
                                    
                                    print("Please make sure your new passwords match.")
                                    invalidMessages = "Please make sure your new passwords match."
                                }
                                else if newPassword.contains(" ") {
                                    invalidMessages = "Password should not contain any whitespace."
                                }
                                else {
                                    print("Forgot password request")
                                    isLoading = true
                                    
                                    forgotPasswordVM.requestChangePassword(email: email.trimmingCharacters(in: .whitespacesAndNewlines), newPassword: newPassword) { success in
                                        
                                        if success {
                                            destinationKey = "emailVerication"
                                        }
                                        else {
                                            invalidMessages = "Please try again."
                                        }
                                        isLoading = false
                                    }
                                }
                                
                            } label: {
                                if newPassword.isEmpty || confirmNewPassword.isEmpty || !isMatchingLength || !isMatchingFormat {
                                    Image("nextButtonInactive")
                                }
                                else {
                                    Image("nextButton")
                                }
                            }
                            .disabled(newPassword.isEmpty || confirmNewPassword.isEmpty || isLoading || !isMatchingLength || !isMatchingFormat)
                            .background(
                                NavigationLink(destination: EmailVerificationView(navigationTitle: "Forgot password", email: email.trimmingCharacters(in: .whitespacesAndNewlines), serverLocation: "/verify_pswdcode", isFinished: $isFinish, emailResendVM: forgotPasswordVM, successMessage: "Password reset successfully!", successSubtitle: "Your password has been reset successfully."), tag: "emailVerication", selection: $destinationKey) {
                                    EmptyView()
                                }
                            )
                            
                            Spacer()
                        }
                        Spacer()
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
                    .onSubmit {
                        if newPasswordKeyboardFocused {
                            newPasswordKeyboardFocused = false
                            confirmNewPasswordKeyboardFocused = true
                        }
                        else if confirmNewPasswordKeyboardFocused {
                            confirmNewPasswordKeyboardFocused = false
                        }
                    }
                }
            }
            
            LoadingView(message: "Loading", isLoading: $isLoading)
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
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                dismiss()
            }
        }))
        .onTapGesture {
            if emailKeyboardFocused {
                emailKeyboardFocused = false
            }
            if newPasswordKeyboardFocused {
                newPasswordKeyboardFocused = false
            }
            if confirmNewPasswordKeyboardFocused {
                confirmNewPasswordKeyboardFocused = false
            }
        }
        .onChange(of: isFinish) { newValue in
            dismiss()
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ForgotPasswordView()
            }
            
            NavigationView {
                ForgotPasswordView(isPresentingEmail: false)
            }
            
            NavigationView {
                ForgotPasswordView()
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
