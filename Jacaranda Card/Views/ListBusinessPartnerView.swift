//
//  ListBusinessPartnerView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 23/7/2022.
//

import SwiftUI

struct ListBusinessPartnerView: View {
    
    @State var businessPartner: BusinessPartner
    
    var body: some View {
        NavigationLink(destination: BusinessPartnerDetailedView(businessPartner: businessPartner)) {
            HStack {
                ZStack(alignment: .bottom) {
                    Image(businessPartner.image)
                        .frame(width: 90, height: 90, alignment: .center)
                        .clipped()
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
                Spacer()
            }
        }
        .padding(.vertical, 9)
        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
        .cornerRadius(12)
        .shadow(color: Color(red: 151/255, green: 151/255, blue: 151/255, opacity: 0.2), radius: 5, x: 2, y: 2)
    }
}

struct ListBusinessPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = BusinessPartnerModel()
        
        ListBusinessPartnerView(businessPartner: model.restaurants[0])
            .previewLayout(.sizeThatFits)
        
        ListBusinessPartnerView(businessPartner: model.beauties[0])
            .previewLayout(.sizeThatFits)
      
        ListBusinessPartnerView(businessPartner: model.tourisms[0])
            .previewLayout(.sizeThatFits)
    }
}
