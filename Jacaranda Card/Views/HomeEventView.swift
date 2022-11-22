//
//  HomeEventView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import SwiftUI

struct HomeEventView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Event")
                .font(Font.custom("DMSans-Bold", size: 14))
                .foregroundColor(Color("eventTextColor"))
                .padding([.top, .bottom], 16)
                .padding(.leading, 24)
            
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image("eventIcon")
                    }
                    .padding(.leading, 18)
                    Text("Jacaranda Event")
                        .foregroundColor(Color("eventContentColor"))
                        .font(Font.custom("DMSans-Bold", size: 14))
                        .padding(.leading, 22)
                        .padding(.bottom, 32)
                    HStack {
                        Spacer()
                        Text("Coming Soon...")
                            .foregroundColor(Color("eventContentColor"))
                            .font(Font.custom("DMSans-Bold", size: 14))
                            .padding(.trailing, 11.5)
                    }
                }
                .frame(width: 300, height: 160)
                .background(Image("eventSample"))
                Spacer()
            }
        }
        .padding(.bottom, 20)
        .background(Color("eventSectionColor"))
    }
}

struct HomeEventView_Previews: PreviewProvider {
    static var previews: some View {
        HomeEventView()
            .previewLayout(.sizeThatFits)
    }
}
