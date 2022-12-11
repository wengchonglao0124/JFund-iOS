//
//  JacarandaHomeView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 21/7/2022.
//

import SwiftUI

struct JacarandaHomeView: View {
    
    @Binding var tabViewSelectionIndex: Int
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    @State var userBalance = "..."
    
    @EnvironmentObject var activityVM: ActivityModel
    
    var body: some View {
        
        ScrollView {
            PullToRefreshView(coordinateSpaceName: "pullToRefreshHomeView") {
                // do your stuff when pulled
                let impact = UIImpactFeedbackGenerator(style: .light)
                impact.impactOccurred()
                userDataVM.updateBalance()
                
                activityVM.updateActivityRecords(accessToken: userDataVM.getAccessToken()!)
            }
            
            VStack(spacing: 0) {
                // MARK: Notification Section
                HStack {
                    Spacer()
                    Image("notification")
                }
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 14)
                
                // MARK: Balance Section
                HomeBalanceView(balance: userBalance, carID: userDataVM.getUserID(), accessToken: userDataVM.getAccessToken()!)
                    .cornerRadius(16)
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 30)
                    .onAppear(perform: {
                        if tabViewSelectionIndex == 1 {
                            userDataVM.updateBalance()
                        }
                    })
                
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
                    NavigationLink(destination: JacarandaTransferView().environmentObject(userDataVM)) {
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
                HomeActivityView(activityModel: activityVM, tabViewSelectionIndex: $tabViewSelectionIndex)
                    .environmentObject(userDataVM)
                    .cornerRadius(16)
                    .padding(.bottom, 30)
                    .onAppear(perform: {
                        if tabViewSelectionIndex == 1 {
                            activityVM.updateActivityRecords(accessToken: userDataVM.getAccessToken()!)
                        }
                    })
                
                // MARK: Event Section
//                HomeEventView()
//                    .cornerRadius(16)
//                    .padding(.bottom, 30)
                
                // MARK: Business Partner Section
                HomeBusinessPartnerView(businessPartnerModel: BusinessPartnerModel())
            }
            .onChange(of: userDataVM.userBalance) { newValue in
                userBalance = userDataVM.userBalance
            }
        }
        .padding(.top, 1)
        .background(Color("screenBg"))
        .coordinateSpace(name: "pullToRefreshHomeView")
    }
}

struct JacarandaHomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let credentials = Credentials.decode("{\"image\":\"#a2d2ff\",\"UserName\":\"billylao\",\"RefreshToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzEzMzk3MDEsImp0aSI6InJlZnJlc2hUb2tlbiJ9.KJSENeGG5vaCMfWh01irNlsUPgvU4jd0_2vB_Xlnwps\",\"UserID\":\"4468674852519615\",\"AccessToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzA4MjEzMDEsImp0aSI6ImFjY2Vzc1Rva2VuIn0.4Nj-KpJUznS86VSHaRn4NlgCZVJiqoe6DT-7IkKAk0M\",\"info\":\"1\"}")
        let isSuccess = KeychainService.saveCredentials(credentials)
        
        let activityModel: ActivityModel = {
            let model = ActivityModel()
            model.updateActivityForTestingOnly()
            return model
        }()
        
        let userDataVM = UserDataViewModel()
        
        if isSuccess {
            Group {
                NavigationView {
                    JacarandaHomeView(tabViewSelectionIndex: .constant(2))
                }
                .environmentObject(userDataVM)
                .environmentObject(activityModel)
                
                NavigationView {
                    JacarandaHomeView(tabViewSelectionIndex: .constant(2))
                }
                .environmentObject(userDataVM)
                .environmentObject(activityModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            }
        }
    }
}

