//
//  JacarandaHomeView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 21/7/2022.
//

import SwiftUI

struct JacarandaHomeView: View {
    
    @Binding var tabViewSelectionIndex: Int
    
    @StateObject var userDataVM = UserDataViewModel()
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                // MARK: Notification Section
                HStack {
                    Spacer()
                    Image("notification")
                }
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 14)
                
                // MARK: Balance Section
                HomeBalanceView(balance: userDataVM.userBalance, carID: userDataVM.getUserID())
                    .cornerRadius(16)
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 30)
                
                // MARK: Payment Section
                HStack {
                    Spacer()
                    NavigationLink(destination: JacarandaPayView(username: "Lilyxoxo", carID: userDataVM.getUserID())) {
                        VStack {
                            Image("payButton")
                            Text("Pay")
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255, opacity: 0.8))
                        }
                    }
                    Spacer()
                    Spacer()
                    NavigationLink(destination: JacarandaTransferView()) {
                        VStack {
                            Image("transferButton")
                            Text("Transfer")
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255, opacity: 0.8))
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 24)
                
                // MARK: Activity Section
                HomeActivityView(activityModel: ActivityModel(), tabViewSelectionIndex: $tabViewSelectionIndex)
                    .cornerRadius(16)
                    .padding(.bottom, 30)
                
                // MARK: Event Section
//                HomeEventView()
//                    .cornerRadius(16)
//                    .padding(.bottom, 30)
                
                // MARK: Business Partner Section
                HomeBusinessPartnerView(businessPartnerModel: BusinessPartnerModel())
            }
        }
        .padding(.top, 1)
        .background(Color("screenBg"))
    }
}

struct JacarandaHomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let credentials = Credentials.decode("{\"UserName\":\"billylao\",\"RefreshToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzA4MjQyNDcsImp0aSI6InJlZnJlc2hUb2tlbiJ9.tnENuGgjbK1wzbgfcN2ofvPSzw54orfGGesg5Xp7c68\",\"UserID\":\"1234567890348372\",\"AccessToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzAzMDU4NDcsImp0aSI6ImFjY2Vzc1Rva2VuIn0.jmrb2FHgh_uJHtuy7PrdzxXL_kaJxVtl-pgLuUrOX7I\",\"info\":\"0\"}")
        let isSuccess = KeychainService.saveCredentials(credentials)
        
        if isSuccess {
            Group {
                NavigationView {
                    JacarandaHomeView(tabViewSelectionIndex: .constant(1))
                }
                
                NavigationView {
                    JacarandaHomeView(tabViewSelectionIndex: .constant(1))
                }
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            }
        }
    }
}

