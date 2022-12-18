//
//  ProfileAccountSecurityView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 14/12/2022.
//

import SwiftUI

struct ProfileAccountSecurityView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    @State var isEnableBiometricID = false
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    var body: some View {
        VStack {
            
            // MARK: Account Section
            VStack(alignment: .leading, spacing: 0) {
                Text("Account")
                    .foregroundColor(Color("profileSectionTitleColor"))
                    .font(Font.custom("DMSans-Medium", size: 14))
                    .padding(.bottom, 9)
                    .padding(.top, 33)
                    .padding(.leading, 16)
                
                VStack {
                    // MARK: Change Password Section
                    NavigationLink(destination: ChangePasswordView()
                        .environmentObject(userDataVM)) {
                        HStack {
                            Text("Change password")
                                .foregroundColor(Color("profileSectionTextColor"))
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .padding(.leading, 21)
                            Spacer()
                            Image("arrow")
                                .padding(.trailing, 10)
                        }
                        .padding(.vertical, 19)
                    }
                    
                    // MARK: Forgot Password Section
                    NavigationLink(destination: ForgotPasswordView()) {
                        HStack {
                            Text("Forgot password")
                                .foregroundColor(Color("profileSectionTextColor"))
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .padding(.leading, 21)
                            Spacer()
                            Image("arrow")
                                .padding(.trailing, 10)
                        }
                        .padding(.vertical, 19)
                    }
                }
                .background(Color("profileSectionColor"))
            }
            
            // MARK: Top-up Section
            VStack(alignment: .leading, spacing: 0) {
                Text("Top-up")
                    .foregroundColor(Color("profileSectionTitleColor"))
                    .font(Font.custom("DMSans-Medium", size: 14))
                    .padding(.bottom, 9)
                    .padding(.top, 33)
                    .padding(.leading, 16)
                
                VStack {
                    // MARK: Change Payment Pin Section
                    NavigationLink(destination: ChangePaymentPinView()
                        .environmentObject(userDataVM)) {
                        HStack {
                            Text("Change payment pin")
                                .foregroundColor(Color("profileSectionTextColor"))
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .padding(.leading, 21)
                            Spacer()
                            Image("arrow")
                                .padding(.trailing, 10)
                        }
                        .padding(.vertical, 19)
                    }
                    
                    // MARK: Forgot Payment Pin Section
                    NavigationLink(destination: ForgotPaymentPinView()
                        .environmentObject(userDataVM)) {
                        HStack {
                            Text("Forgot payment pin")
                                .foregroundColor(Color("profileSectionTextColor"))
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .padding(.leading, 21)
                            Spacer()
                            Image("arrow")
                                .padding(.trailing, 10)
                        }
                        .padding(.vertical, 19)
                    }
                    
                    // MARK: Enable Face Or Touch ID Section
                    HStack {
                        Text("Enable Face / Touch ID")
                            .foregroundColor(Color("profileSectionTextColor"))
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .padding(.leading, 21)
                        Spacer()
                        
                        Toggle("", isOn: $isEnableBiometricID)
                            .frame(maxHeight: 24)
                            .padding(.trailing, 10)
                            .toggleStyle(SwitchToggleStyle(tint: Color(red: 87/255, green: 40/255, blue: 126/255)))
                    }
                    .padding(.vertical, 19)
                }
                .background(Color("profileSectionColor"))
            }
            Spacer()
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Account Security")
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
    }
}

struct ProfileAccountSecurityView_Previews: PreviewProvider {
    static var previews: some View {
        
        let userDataVM = UserDataViewModel()
        
        NavigationView {
            ProfileAccountSecurityView()
        }
        .environmentObject(userDataVM)
    }
}
