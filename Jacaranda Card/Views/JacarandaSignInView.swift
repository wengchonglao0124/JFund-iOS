//
//  JacarandaSignInView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 29/11/2022.
//

import SwiftUI

struct JacarandaSignInView: View {
    
    @State var email = ""
    @State private var password = ""
    @State private var isSecured: Bool = true
    @State var rememberInfo = false
    
    @FocusState private var emailKeyboardFocused: Bool
    @FocusState private var passwordKeyboardFocused: Bool
    
    private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    
    @State var invalidMessages = ""
    @State var isLoading = false
    @State var isLoginSuccess = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .leading, spacing: 0) {
                    // MARK: Sign In Title Section
                    Text("Sign in")
                        .font(Font.custom("DMSans-Medium", size: 20))
                        .foregroundColor(Color(red: 18/255, green: 13/255, blue: 38/255))
                        .padding(.bottom, 31)
                    
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
                    .padding(.bottom, 22)
                    .onTapGesture {
                        emailKeyboardFocused = true
                    }
                    
                    // MARK: Password Input Section
                    VStack {
                        HStack(spacing: 11) {
                            Image("passwordLogo")
                            
                            if isSecured {
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
                                    .textInputAutocapitalization(.never)
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
                                    .textInputAutocapitalization(.never)
                            }
                                
                            Button {
                                isSecured.toggle()
                            } label: {
                                if isSecured {
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
                    .padding(.bottom, 49)
                    .onTapGesture {
                        passwordKeyboardFocused = true
                    }
                    
                    // MARK: Utilities Section
                    HStack(alignment: .center, spacing: 0) {
                        // MARK: Checkbox Section
                        Button {
                            rememberInfo.toggle()
                        } label: {
                            if rememberInfo == false {
                                Image("checkboxInactive")
                            }
                            else {
                                Image("checkboxActive")
                                    .animation(.easeInOut, value: rememberInfo)
                            }
                            
                            Text("Remember me")
                                .font(Font.custom("DMSans-Regular", size: 14))
                                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                                .padding(.leading, 11)
                        }
                        Spacer()
                        
                        // MARK: Forgot Password Section
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot Password?")
                                .font(Font.custom("DMSans-Regular", size: 14))
                                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                        }
                    }
                    .padding(.bottom, 38)
                    
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
                    
                    // MARK: Sign In Button Section
                    HStack {
                        Spacer()
                        Button {
                            invalidMessages = ""
                            isLoading = true
                            print("Sign In")
                            
                            loginVM.login(email: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines)) { success in
                                
                                if success {
                                    isLoginSuccess = true
                                }
                                else {
                                    invalidMessages = "Either your email or password are incorrect. Please try again"
                                }
                                isLoading = false
                            }
                            
                        } label: {
                            if email.isEmpty || password.isEmpty {
                                Image("signInButtonInactive")
                            }
                            else {
                                Image("signInButton")
                            }
                        }
                        .disabled(email.isEmpty || password.isEmpty)
                        Spacer()
                    }
                    Spacer()
                    
                    // MARK: Sign Up Section
                    HStack {
                        Spacer()
                        Text("Don’t have an account?")
                            .font(Font.custom("DMSans-Regular", size: 15))
                            .foregroundColor(Color(red: 18/255, green: 13/255, blue: 38/255))
                            .padding(.trailing, 2)
                        
                        NavigationLink(destination: JacarandaSignUpView()) {
                            Text("Sign up")
                                .font(Font.custom("DMSans-Regular", size: 15))
                                .foregroundColor(Color(red: 87/255, green: 40/255, blue: 126/255))
                        }
                        Spacer()
                    }
                    .padding(.bottom, 15)
                }
                .padding(.top, 69)
                .padding(.leading, 32)
                .padding(.trailing, 22)
                .background(Color(red: 246/255, green: 246/255, blue: 246/255))
            }
            .onSubmit {
                if emailKeyboardFocused {
                    emailKeyboardFocused = false
                    passwordKeyboardFocused = true
                } else if passwordKeyboardFocused {
                    passwordKeyboardFocused = false
                }
            }
            .disabled(isLoading)
            
            LoadingView(message: "Loading", isLoading: $isLoading)
        }
        .onTapGesture {
            if emailKeyboardFocused {
                emailKeyboardFocused = false
            }
            
            if passwordKeyboardFocused {
                passwordKeyboardFocused = false
            }
        }
        .onChange(of: isLoginSuccess, perform: { newValue in
            authentication.updateValidation(success: true)
        })
        .onAppear(perform: {
            email = ""
            password = ""
            isSecured = true
            rememberInfo = false
            isLoginSuccess = false
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct JacarandaSignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JacarandaSignInView()
            
            JacarandaSignInView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
