//
//  JacarandaProfileView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 21/7/2022.
//

import SwiftUI

struct JacarandaProfileView: View {
    
    @State var userName: String
    var carID: String
    
    @State var isShowingLogout = false
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    VStack {
                        // MARK: Username Section
                        HStack(spacing: 5) {
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 215/255, green: 199/255, blue: 228/255))
                                        .frame(width: 63, height: 63)
                                    Text(userName.prefix(1))
                                        .font(Font.custom("DMSans-Bold", size: 32))
                                        .foregroundColor(.white)
                                }
                            
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(userName)
                                        .font(Font.custom("DMSans-Bold", size: 18))
                                    Text(carID)
                                        .font(Font.custom("DMSans-Medium", size: 14))
                                }
                                .padding(.leading, 10)
                            }
                            .padding(.leading, 16)
                            Spacer()
                        }
                        .padding(.vertical, 15.5)
                        .background(Color("profileSectionColor"))
                    }
                    .padding(.top, 47.5)
                    
                    
                    // MARK: Profile and Security Section
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Profile & Security")
                            .foregroundColor(Color("profileSectionTitleColor"))
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .padding(.bottom, 9)
                            .padding(.top, 25)
                            .padding(.leading, 16)
                        
                        VStack {
                            // MARK: Account Security
                            NavigationLink(destination: Text("Account Security")) {
                                HStack(spacing: 10) {
                                    Image("security")
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(12)
                                        .padding(.leading, 16)
                                    Text("Account Security")
                                        .foregroundColor(Color("profileSectionTextColor"))
                                        .font(Font.custom("DMSans-Medium", size: 14))
                                    Spacer()
                                    Image("arrow")
                                        .padding(.trailing, 10)
                                }
                                .padding(.vertical, 12)
                            }
                            // MARK: Payment Settings
                            NavigationLink(destination: Text("Payment Settings")) {
                                HStack(spacing: 10) {
                                    Image("paymentSetting")
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(12)
                                        .padding(.leading, 16)
                                    Text("Payment Settings")
                                        .foregroundColor(Color("profileSectionTextColor"))
                                        .font(Font.custom("DMSans-Medium", size: 14))
                                    Spacer()
                                    Image("arrow")
                                        .padding(.trailing, 10)
                                }
                                .padding(.vertical, 12)
                            }
                        }
                        .padding(.vertical, 6)
                        .background(Color("profileSectionColor"))
                    }
                    
                    
                    // MARK: Message Section
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Message")
                            .foregroundColor(Color("profileSectionTitleColor"))
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .padding(.bottom, 9)
                            .padding(.top, 18)
                            .padding(.leading, 16)
                        
                        VStack {
                            // MARK: Notification Preferences
                            NavigationLink(destination: Text("Notification Preferences")) {
                                HStack(spacing: 10) {
                                    Image("notificationPreference")
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(12)
                                        .padding(.leading, 16)
                                    Text("Notification Preferences")
                                        .foregroundColor(Color("profileSectionTextColor"))
                                        .font(Font.custom("DMSans-Medium", size: 14))
                                    Spacer()
                                    Image("arrow")
                                        .padding(.trailing, 10)
                                }
                                .padding(.vertical, 12)
                            }
                        }
                        .padding(.vertical, 6)
                        .background(Color("profileSectionColor"))
                    }
                        
                    
                    // MARK: About Section
                    VStack(alignment: .leading, spacing: 0) {
                        Text("About")
                            .foregroundColor(Color("profileSectionTitleColor"))
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .padding(.bottom, 9)
                            .padding(.top, 25)
                            .padding(.leading, 16)
                        
                        VStack {
                            // MARK: Help & Support
                            NavigationLink(destination: Text("Help & Support")) {
                                HStack(spacing: 10) {
                                    Image("help")
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(12)
                                        .padding(.leading, 16)
                                    Text("Help & Support")
                                        .foregroundColor(Color("profileSectionTextColor"))
                                        .font(Font.custom("DMSans-Medium", size: 14))
                                    Spacer()
                                    Image("arrow")
                                        .padding(.trailing, 10)
                                }
                                .padding(.vertical, 12)
                            }
                            
                            // MARK: Terms of Use
                            NavigationLink(destination: Text("Terms of Use")) {
                                HStack(spacing: 10) {
                                    Image("termsOfUse")
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(12)
                                        .padding(.leading, 16)
                                    Text("Terms of Use")
                                        .foregroundColor(Color("profileSectionTextColor"))
                                        .font(Font.custom("DMSans-Medium", size: 14))
                                    Spacer()
                                    Image("arrow")
                                        .padding(.trailing, 10)
                                }
                                .padding(.vertical, 12)
                            }
                            
                            // MARK: Contact us
                            NavigationLink(destination: Text("Contact us")) {
                                HStack(spacing: 10) {
                                    Image("contactUs")
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(12)
                                        .padding(.leading, 16)
                                    Text("Contact us")
                                        .foregroundColor(Color("profileSectionTextColor"))
                                        .font(Font.custom("DMSans-Medium", size: 14))
                                    Spacer()
                                    Image("arrow")
                                        .padding(.trailing, 10)
                                }
                                .padding(.vertical, 12)
                            }
                        }
                        .padding(.vertical, 6)
                        .background(Color("profileSectionColor"))
                    }
                    

                    // MARK: Log out Section
                    VStack {
                        // MARK: Log out
                        HStack(spacing: 10) {
                            Spacer()
                            Button {
                                isShowingLogout = true
                            } label: {
                                Text("Log out")
                                    .foregroundColor(Color(red: 201/255, green: 37/255, blue: 45/255))
                                    .font(Font.custom("DMSans-Medium", size: 14))
                            }
                            Spacer()
                        }
                        .padding(.vertical, 17.5)
                    }
                    .background(Color("profileSectionColor"))
                    .padding(.top, 34)
                    .padding(.bottom, 22)
                }
            }
            
            ConfirmLogoutView(isPresenting: $isShowingLogout)
        }
        .background(Color("screenBg"))
    }
}

struct JacarandaProfileView_Previews: PreviewProvider {
    static var previews: some View {
        JacarandaProfileView(userName: "Lilyxoxo", carID: "1234 5678 3657 5623")
    }
}
