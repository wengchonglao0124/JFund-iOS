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
    
    var body: some View {
        
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
                                    .font(.system(size: 32))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        
                            VStack(alignment: .leading, spacing: 10) {
                                Text(userName)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                Text(carID)
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
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
                        .fontWeight(.medium)
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
                                    .fontWeight(.medium)
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
                                    .fontWeight(.medium)
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
                .font(.system(size: 14))
                
                
                // MARK: Message Section
                VStack(alignment: .leading, spacing: 0) {
                    Text("Message")
                        .foregroundColor(Color("profileSectionTitleColor"))
                        .fontWeight(.medium)
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
                                    .fontWeight(.medium)
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
                .font(.system(size: 14))
                    
                
                // MARK: About Section
                VStack(alignment: .leading, spacing: 0) {
                    Text("About")
                        .foregroundColor(Color("profileSectionTitleColor"))
                        .fontWeight(.medium)
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
                                    .fontWeight(.medium)
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
                                    .fontWeight(.medium)
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
                                    .fontWeight(.medium)
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
                .font(.system(size: 14))
                

                // MARK: Log out Section
                VStack {
                    // MARK: Log out
                    NavigationLink(destination: Text("Log out")) {
                        HStack(spacing: 10) {
                            Image("Logout")
                                .frame(width: 40, height: 40)
                                .cornerRadius(12)
                                .padding(.leading, 16)
                            Text("Log out")
                                .foregroundColor(Color("profileSectionTextColor"))
                                .fontWeight(.medium)
                            Spacer()
                        }
                        .padding(.vertical, 12)
                    }
                }
                .background(Color("profileSectionColor"))
                .font(.system(size: 14))
                .padding(.top, 34)
                .padding(.bottom, 22)
            }
        }
        .background(Color("screenBg"))
    }
}

struct JacarandaProfileView_Previews: PreviewProvider {
    static var previews: some View {
        JacarandaProfileView(userName: "Lilyxoxo", carID: "1234 5678 3657 5623")
    }
}
