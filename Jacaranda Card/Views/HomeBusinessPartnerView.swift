//
//  HomeBusinessPartnerView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import SwiftUI

struct HomeBusinessPartnerView: View {
    
    @State var businessPartnerModel: BusinessPartnerModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            // MARK: Business Partner Title Section
            Text("Business Partner")
                .font(Font.custom("DMSans-Bold", size: 14))
                .foregroundColor(Color("businessPartnerTextColor"))
                .padding(.vertical, 16)
                .padding(.leading, 24)
            
            // MARK: Restaurant List Section
            LazyVStack {
                ForEach(businessPartnerModel.restaurants) { restaurant in
                    ListBusinessPartnerView(businessPartner: restaurant)
                }
            }
            .padding(.horizontal, 27.7)
        }
        .background(Color("homeBusinessPartnerSectionColor"))
    }
}

struct HomeBusinessPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScrollView(showsIndicators: false) {
                HomeBusinessPartnerView(businessPartnerModel: BusinessPartnerModel())
            }
            //.previewLayout(.sizeThatFits)
            
            ScrollView(showsIndicators: false) {
                HomeBusinessPartnerView(businessPartnerModel: BusinessPartnerModel())
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}

