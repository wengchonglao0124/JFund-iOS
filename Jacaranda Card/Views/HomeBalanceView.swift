//
//  HomeBalanceView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import SwiftUI

struct HomeBalanceView: View {
    
    @State var balance: String
    var carID: String
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 17) {
                Text("Balace")
                    .foregroundColor(Color("balanceSectionColor"))
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                
                Label(balance, image: "balance")
                    .foregroundColor(Color("balanceColor"))
                    .font(.system(size: 18).bold())
            
                Text(carID)
                    .foregroundColor(Color("balanceSectionColor"))
                    .font(.system(size: 14))
                    .fontWeight(.bold)
            }
            Spacer()
            Image("addBalance")
        }
        .padding([.top, .bottom], 20)
        .padding(.leading, 27)
        .padding(.trailing, 13)
        .background(LinearGradient(colors: [Color(red: 82/255, green: 36/255, blue: 121/255), Color(red: 108/255, green: 58/255, blue: 150/255), Color(red: 125/255, green: 72/255, blue: 169/255), Color(red: 155/255, green: 98/255, blue: 204/255)], startPoint: .bottomLeading, endPoint: .topTrailing))
    }
}

struct HomeBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBalanceView(balance: "0.00", carID: "1234 5678 3657 5623")
            .previewLayout(.sizeThatFits)
    }
}
