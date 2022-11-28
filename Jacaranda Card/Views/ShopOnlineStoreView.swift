//
//  ShopOnlineStoreView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 28/11/2022.
//

import SwiftUI

struct ShopOnlineStoreView: View {
    
    var status = "inactive"
    
    var body: some View {
        if status == "inactive" {
            VStack(alignment: .center, spacing: 30) {
                Image("onlineStoreComingSoon")
                    .padding(.top, 74)
                
                Text("Online store is coming soon")
                    .font(Font.custom("DMSans-Bold", size: 16))
                    .foregroundColor(.black)
            }
        }
    }
}

struct ShopOnlineStoreView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ShopOnlineStoreView()
            
            ShopOnlineStoreView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
