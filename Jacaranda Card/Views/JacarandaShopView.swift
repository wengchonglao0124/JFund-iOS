//
//  JacarandaShopView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 28/11/2022.
//

import SwiftUI

struct JacarandaShopView: View {
    
    private var promotionList = ["topUpPromotion", "pizzaHutPromotion"]
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                // MARK: Promotion Section
                TabView {
                    ForEach(promotionList, id: \.self) { imageName in
                        if imageName == "pizzaHutPromotion" {
                            NavigationLink(destination: TestingPromotionView(companyName: "Pizza Hut", title: "Hawaiian Pizza & Ice cream 10% off in Valentines day ", description: "Pizza Hut Hawaiian Pizza & Ice cream 10% off in 14/02 Valentines day (not avaliable with any other deals)\n\nOnly in Valentines day!! ", endDate: Date())) {
                                Image(imageName)
                                    .frame(width: 320, height: 160)
                                    .cornerRadius(16)
                            }
                        }
                        else {
                            Image(imageName)
                                .frame(width: 320, height: 160)
                                .cornerRadius(16)
                        }
                    }
                }
                .frame(width: 320, height: 180)
                .padding(.top, 15)
                .padding(.bottom, 32)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .automatic))
                
                // MARK: Online Store Section
                ShopOnlineStoreView()
                
                Spacer()
            }
            Spacer()
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
    }
}

struct JacarandaShopView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JacarandaShopView()
            
            JacarandaShopView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
