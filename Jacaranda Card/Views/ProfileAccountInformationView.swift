//
//  ProfileAccountInformationView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 13/12/2022.
//

import SwiftUI

struct ProfileAccountInformationView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: User Icon Section
            ZStack {
                Circle()
                    .fill(Color(hex: userDataVM.userImage)!)
                    .frame(width: 63, height: 63)
                Text(userDataVM.userName.prefix(1))
                    .font(Font.custom("DMSans-Bold", size: 32))
                    .foregroundColor(.white)
            }
            .padding(.top, 30)
            .padding(.bottom, 8)
            
            NavigationLink(destination: ChangeUserImageView(username: userDataVM.userName, userImage: userDataVM.userImage)
                .environmentObject(userDataVM)) {
                Text("Change icon color")
                    .font(Font.custom("DMSans-Medium", size: 12))
                    .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
            }
            .padding(.bottom, 30)

            VStack(spacing: 0) {
                
                // MARK: Username Section
                NavigationLink(destination: ChangeUsernameView()
                    .environmentObject(userDataVM)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Username")
                                .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                                .font(Font.custom("DMSans-Medium", size: 12))
                            
                            Text(userDataVM.userName)
                                .foregroundColor(Color("profileSectionTextColor"))
                                .font(Font.custom("DMSans-Medium", size: 14))
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                        Image("arrow")
                            .padding(.trailing, 10)
                    }
                    .padding(.vertical, 12)
                }
                
                // MARK: User Email Section
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Email")
                            .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                            .font(Font.custom("DMSans-Medium", size: 12))
                        
                        Text(userDataVM.getUserEmail())
                            .foregroundColor(Color("profileSectionTextColor"))
                            .font(Font.custom("DMSans-Medium", size: 14))
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                .padding(.vertical, 12)
                
                // MARK: User ID Section
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("User ID")
                            .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                            .font(Font.custom("DMSans-Medium", size: 12))
                        
                        Text(userDataVM.getUserID())
                            .foregroundColor(Color("profileSectionTextColor"))
                            .font(Font.custom("DMSans-Medium", size: 14))
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                .padding(.vertical, 12)
            }
            .background(Color("profileSectionColor"))
            
            Spacer()
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Account information")
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

struct ProfileAccountInformationView_Previews: PreviewProvider {
    static var previews: some View {
        
        let data = "{\"image\":\"#a2d2ff\",\"UserName\":\"billylao\",\"RefreshToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzEzMzk3MDEsImp0aSI6InJlZnJlc2hUb2tlbiJ9.KJSENeGG5vaCMfWh01irNlsUPgvU4jd0_2vB_Xlnwps\",\"UserID\":\"4468674852519615\",\"AccessToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzA5OTg0MTksImp0aSI6ImFjY2Vzc1Rva2VuIn0.1rePQXaCCkptakRTfZEdrpptIAPG2_uO-lk0kLfqDKE\",\"info\":\"1\"}"
        
        let credentials = Credentials.decode(data)
        let isSuccess = KeychainService.saveCredentials(credentials)
        
        if isSuccess {
            
            let userDataVM = UserDataViewModel()
            
            let userData = UserData.decode(data)
            
            NavigationView {
                ProfileAccountInformationView()
            }
            .environmentObject(userDataVM)
            .onAppear(perform: {
                UserDefaults.standard.set(userData.UserName, forKey: "userName")
                UserDefaults.standard.set(userData.image, forKey: "userImage")
                UserDefaults.standard.set("billylao888@gmail.com", forKey: "userEmail")
            })
        }
    }
}
