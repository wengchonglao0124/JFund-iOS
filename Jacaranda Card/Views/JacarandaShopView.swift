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
                        Image(imageName)
                            .frame(width: 320, height: 160)
                            .cornerRadius(16)
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
