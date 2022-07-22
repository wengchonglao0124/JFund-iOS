//
//  ListBusinessPartnerView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 23/7/2022.
//

import SwiftUI

struct ListBusinessPartnerView: View {
    
    var businessPartner: BusinessPartner
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.gray)
                HStack {
                    Spacer()
                    Text(businessPartner.distance)
                        .font(.system(size: 8))
                        .fontWeight(.regular)
                        .foregroundColor(Color(red: 252/255, green: 252/255, blue: 252/255))
                    Spacer()
                }
                .padding(.vertical, 2)
                .background(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
            }
            .frame(width: 90, height: 90, alignment: .center)
            .padding(.trailing, 16)
            .padding(.leading, 11.5)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(businessPartner.name)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text(businessPartner.address)
                    .font(.system(size: 10))
                    .fontWeight(.regular)
                    .foregroundColor(Color("businessPartnerAddressColor"))
            }
            .padding(.trailing, 19.5)
        }
        .padding(.vertical, 9)
        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
        .cornerRadius(12)
        .shadow(color: Color(red: 151/255, green: 151/255, blue: 151/255, opacity: 0.2), radius: 5, x: 2, y: 2)
    }
}

struct ListBusinessPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        
        let businessPartner = BusinessPartner(id: UUID(), name: "Restaurant name", address: "111 Melbourne Street, South Brisbane, QLD 4101, Australia", distance: "1.2 km")
        ListBusinessPartnerView(businessPartner: businessPartner)
            .previewLayout(.sizeThatFits)
    }
}
