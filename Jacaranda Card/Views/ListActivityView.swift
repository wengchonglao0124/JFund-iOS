//
//  ListActivityView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import SwiftUI

struct ListActivityView: View {
    
    var activity: Activity
    
    var body: some View {
        NavigationLink(destination: ActivityDetailedView(activity: activity)) {
            HStack {
                HStack(spacing: 16) {
                    Image(activity.imageName)
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(activity.name)
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .foregroundColor(Color("activityTextColor"))
                        
                        Text(DateService.getDateString(format: "dd MMM", date: activity.date))
                            .font(Font.custom("DMSans-Medium", size: 12))
                            .foregroundColor(Color("activityDateColor"))
                    }
                }
                Spacer()
                if activity.amount >= 0 {
                    Text(activity.amountString)
                        .font(Font.custom("DMSans-Medium", size: 16))
                        .foregroundColor(Color("activityAddAmountColor"))
                }
                else {
                    Text(activity.amountString)
                        .font(Font.custom("DMSans-Medium", size: 16))
                        .foregroundColor(Color("activityTextColor"))
                }
            }
        }
        .padding([.leading, .top, .bottom], 13)
        .padding(.trailing, 10)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color(red: 151/255, green: 151/255, blue: 151/255, opacity: 0.1), radius: 4, x: 2, y: 2)
    }
}

struct ListActivityView_Previews: PreviewProvider {
    static var previews: some View {
        
        let activityModel = ActivityModel()
        ListActivityView(activity: activityModel.activies[0])
            .previewLayout(.sizeThatFits)
    }
}
