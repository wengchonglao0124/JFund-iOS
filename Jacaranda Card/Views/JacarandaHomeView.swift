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
    
    @Binding var tabViewSelectionIndex: Int
    
    var body: some View {
        
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
                    NavigationLink(destination: JacarandaPayView(username: "Lilyxoxo", carID: "1234 5678 3657 5623")) {
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
                HomeEventView()
                    .cornerRadius(16)
                    .padding(.bottom, 30)
                
                // MARK: Business Partner Section
                HomeBusinessPartnerView(businessPartnerModel: BusinessPartnerModel(), screenHeight: screenHeight)
            }
        }
        .background(Color("screenBg"))
    }
}

struct JacarandaHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                JacarandaHomeView(screenHeight: UIScreen.main.bounds.height, offsetPosition: 0, tabViewSelectionIndex: .constant(1))
            }
        
            NavigationView {
                JacarandaHomeView(screenHeight: UIScreen.main.bounds.height, offsetPosition: 0, tabViewSelectionIndex: .constant(1))
                    .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            }
        }
    }
}

