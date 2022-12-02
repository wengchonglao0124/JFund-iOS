//
//  JacarandaSignUpView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 29/11/2022.
//

import SwiftUI

struct JacarandaSignUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    @FocusState private var userNameKeyboardFocused: Bool
    @FocusState private var emailKeyboardFocused: Bool
    @FocusState private var passwordKeyboardFocused: Bool
    @FocusState private var confirmPasswordKeyboardFocused: Bool
    
    @State var userName = ""
    @State var email = ""
    @State var password = ""
    @State private var isPasswordSecured: Bool = true
    @State var confirmPassword = ""
    @State private var isConfirmPasswordSecured: Bool = true
    @State var acceptInfo = false
    @State var invalidMessages = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Sign up")
                .font(Font.custom("DMSans-Medium", size: 20))
                .foregroundColor(Color(red: 18/255, green: 13/255, blue: 38/255))
                .padding(.top, 31)
                .padding(.bottom, 29)
            
            // MARK: Username Input Section
            VStack {
                HStack(spacing: 11) {
                    Image("usernameLogo")
                    
                    TextField("Username", text: $userName)
                        .font(Font.custom("DMSans-Medium", size: 14))
                        .foregroundColor({
                            if userName.isEmpty {
                                return Color("PlaceholderTextColor")
                            }
                            else {
                                return Color("FieldTextColor")
                            }
                        }())
                        .keyboardType(.default)
                        .focused($userNameKeyboardFocused)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color("FieldBgColor"))
            }
            .cornerRadius(5)
            .padding(.bottom, 22)
            
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
                        .textInputAutocapitalization(.never)
                        .focused($emailKeyboardFocused)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color("FieldBgColor"))
            }
            .cornerRadius(5)
            .padding(.bottom, 22)
            
            // MARK: Password Input Section
            VStack {
                HStack(spacing: 11) {
                    Image("passwordLogo")
                    
                    if isPasswordSecured {
                        SecureField("Password", text: $password)
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor({
                                if password.isEmpty {
                                    return Color("PlaceholderTextColor")
                                }
                                else {
                                    return Color("FieldTextColor")
                                }
                            }())
                            .keyboardType(.default)
                            .focused($passwordKeyboardFocused)
                    }
                    else {
                        TextField("Password", text: $password)
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor({
                                if password.isEmpty {
                                    return Color("PlaceholderTextColor")
                                }
                                else {
                                    return Color("FieldTextColor")
                                }
                            }())
                            .keyboardType(.default)
                            .focused($passwordKeyboardFocused)
                    }
                        
                    Button {
                        isPasswordSecured.toggle()
                    } label: {
                        if isPasswordSecured {
                            Image("isSecured")
                        }
                        else {
                            Image("notSecured")
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color("FieldBgColor"))
            }
            .cornerRadius(5)
            .padding(.bottom, 22)
            
            // MARK: Confirm Password Input Section
            VStack {
                HStack(spacing: 11) {
                    Image("passwordLogo")
                    
                    if isConfirmPasswordSecured {
                        SecureField("Confirm Password", text: $confirmPassword)
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor({
                                if confirmPassword.isEmpty {
                                    return Color("PlaceholderTextColor")
                                }
                                else {
                                    return Color("FieldTextColor")
                                }
                            }())
                            .keyboardType(.default)
                            .focused($confirmPasswordKeyboardFocused)
                    }
                    else {
                        TextField("Confirm Password", text: $confirmPassword)
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor({
                                if confirmPassword.isEmpty {
                                    return Color("PlaceholderTextColor")
                                }
                                else {
                                    return Color("FieldTextColor")
                                }
                            }())
                            .keyboardType(.default)
                            .focused($confirmPasswordKeyboardFocused)
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
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color("FieldBgColor"))
            }
            .cornerRadius(5)
            .padding(.bottom, 40)
            
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
            
            // MARK: Sign Up Button Section
            HStack {
                Spacer()
                Button {
                    invalidMessages = ""
                    if !PasswordService.checkSamePasswords(password1: password, password2: confirmPassword) {
                        print("Please make sure your passwords match.")
                        invalidMessages = "Please make sure your passwords match."
                    }
                    else if !acceptInfo {
                        print("Please read and accept the Terms of use by checking the box.")
                        invalidMessages = "Please read and accept the Terms of use by checking the box."
                    }
                    else {
                        print("Sign Up")
                    }
                } label: {
                    if userName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                        Image("signUpButtonInactive")
                    }
                    else {
                        Image("signUpButton")
                    }
                }
                .disabled(userName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
                Spacer()
            }
            .padding(.bottom, 30)
            
            // MARK: Agree Terms Of Use Section
            HStack(alignment: .center, spacing: 0) {
                // MARK: Checkbox Section
                Button {
                    acceptInfo.toggle()
                } label: {
                    if acceptInfo == false {
                        Image("checkboxInactive")
                    }
                    else {
                        Image("checkboxActive")
                            .animation(.easeInOut, value: acceptInfo)
                    }
                    
                    Text("You accept JFund’s")
                        .font(Font.custom("DMSans-Regular", size: 14))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                        .padding(.leading, 11)
                }
                .padding(.trailing, 5)
                
                // MARK: Terms Of Use Section
                NavigationLink(destination: TermsOfUseView()) {
                    Text("Terms of use")
                        .font(Font.custom("DMSans-Regular", size: 14))
                        .foregroundColor(Color(red: 87/255, green: 40/255, blue: 126/255))
                }
            }
            Spacer()
            
            // MARK: Sign In Section
            HStack {
                Spacer()
                Text("Already have an account?")
                    .font(Font.custom("DMSans-Regular", size: 15))
                    .foregroundColor(Color(red: 18/255, green: 13/255, blue: 38/255))
                    .padding(.trailing, 2)
                
                NavigationLink(destination: JacarandaSignInView()) {
                    Text("Sign in")
                        .font(Font.custom("DMSans-Regular", size: 15))
                        .foregroundColor(Color(red: 87/255, green: 40/255, blue: 126/255))
                }
                Spacer()
            }
            .padding(.bottom, 15)
        }
        .padding(.leading, 32)
        .padding(.trailing, 22)
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .onTapGesture {
            userNameKeyboardFocused = false
            emailKeyboardFocused = false
            passwordKeyboardFocused = false
            confirmPasswordKeyboardFocused = false
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}

struct JacarandaSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                JacarandaSignUpView()
            }
            
            NavigationView {
                JacarandaSignUpView()
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
