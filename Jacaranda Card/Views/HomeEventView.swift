//
//  HomeEventView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import SwiftUI

struct HomeEventView: View {
    var body: some View {
        
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                Text("Event")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(Color("eventTextColor"))
                    .padding([.top, .bottom], 16)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image("eventIcon")
                    }
                    .padding(.leading, 18)
                    Text("Jacaranda Event")
                        .foregroundColor(Color("eventContentColor"))
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .padding(.leading, 22)
                        .padding(.bottom, 32)
                    HStack {
                        Spacer()
                        Text("Coming Soon...")
                            .foregroundColor(Color("eventContentColor"))
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .padding(.trailing, 11.5)
                    }
                }
                .frame(width: 300, height: 160)
                .background(Image("eventSample"))
            }
            .padding(.bottom, 20)
            Spacer()
        }
        .background(Color("eventSectionColor"))
    }
}

struct HomeEventView_Previews: PreviewProvider {
    static var previews: some View {
        HomeEventView()
            .previewLayout(.sizeThatFits)
    }
}
