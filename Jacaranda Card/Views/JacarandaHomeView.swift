//
//  JacarandaHomeView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 21/7/2022.
//

import SwiftUI

struct JacarandaHomeView: View {
    
    var screenHeight: CGFloat
    var offsetPosition: CGFloat
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    // MARK: Notification Section
                    HStack {
                        Spacer()
                        Image("notification")
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 14)
                    
                    // MARK: Balance Section
                    HomeBalanceView(balance: "0.00", carID: "1234 5678 3657 5623")
                        .cornerRadius(16)
                        .padding([.leading, .trailing], 20)
                        .padding(.bottom, 30)
                    
                    // MARK: Payment Section
                    HStack {
                        Spacer()
                        VStack {
                            Image("payButton")
                            Text("Pay")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                        }
                        Spacer()
                        Spacer()
                        VStack {
                            Image("transferButton")
                            Text("Transfer")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 24)
                    
                    // MARK: Activity Section
                    HomeActivityView(activityModel: ActivityModel())
                        .cornerRadius(16)
                        .padding(.bottom, 30)
                    
                    // MARK: Event Section
                    HomeEventView()
                        .cornerRadius(16)
                        .padding(.bottom, 30)
                    
                    // MARK: Business Partner Section
                    HomeBusinessPartnerView(businessPartnerModel: BusinessPartnerModel(), screenHeight: screenHeight)
                }
            }
            .navigationBarHidden(true)
            .background(Color("screenBg"))
        }
    }
}

struct JacarandaHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JacarandaHomeView(screenHeight: UIScreen.main.bounds.height, offsetPosition: 0)
        
            JacarandaHomeView(screenHeight: UIScreen.main.bounds.height, offsetPosition: 0)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}

