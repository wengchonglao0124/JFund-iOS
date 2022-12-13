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
    
    var body: some View {
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
                        .textInputAutocapitalization(.never)
                        .focused($emailKeyboardFocused)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color("FieldBgColor"))
            }
            .cornerRadius(5)
            .padding(.bottom, 43)
            
            Button {
                print("Next: Forgot password")
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
        .padding(.horizontal, 27)
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
            emailKeyboardFocused = false
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                dismiss()
            }
        }))
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ForgotPasswordView()
            }
            
            NavigationView {
                ForgotPasswordView()
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
