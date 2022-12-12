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
            
            ZStack {
                HStack {
                    HStack(spacing: 16) {
                        
                        if activity.imageName.first == "#" {
                            ZStack(alignment: .center) {
                                Rectangle()
                                    .fill(Color(hex: activity.imageName)!)
                                
                                Text(activity.username.prefix(1))
                                    .font(Font.custom("DMSans-Bold", size: 18))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 40, height: 40, alignment: .center)
                            .cornerRadius(20)
                        }
                        else if activity.imageName == "topUpIcon" {
                            
                            Image(activity.imageName)
                                .frame(width: 40, height: 40, alignment: .center)
                                .cornerRadius(12)
                        }
                        else {
                            Image("apple")
                                .frame(width: 40, height: 40, alignment: .center)
                                .cornerRadius(12)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(activity.username)
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .foregroundColor(Color("activityTextColor"))
                            
                            Text(DateService.getDateString(format: "dd MMM", date: activity.date))
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .foregroundColor(Color("activityDateColor"))
                        }
                    }
                    Spacer()
                    
                    if activity.type == "receive" || activity.type == "top-up" {
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
                .padding([.leading, .top, .bottom], 13)
                .padding(.trailing, 10)
                
                // MARK: Extra Bonus Section
                if activity.type == "top-up" && activity.isHavingBonus {
                    HStack {
                        Spacer()
                        Text(activity.extraAmount)
                            .font(Font.custom("DMSans-Medium", size: 12))
                            .foregroundColor(.white)
                            .padding(.leading, activity.bonusLength == 2 ? 23 : 20)
                            .padding(.trailing, activity.bonusLength == 2 ? 20 : 15)
                            .padding(.vertical, 1)
                            .background(LinearGradient(colors: [Color(red: 240/255, green: 95/255, blue: 87/255), Color(red: 174/255, green: 10/255, blue: 10/255)], startPoint: .bottomLeading, endPoint: .topTrailing))
                            .offset(x: 10, y: -3.5)
                            .shadow(color: Color(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.25), radius: 2, x: 0, y: 1)
                            .rotationEffect(Angle(degrees: 30), anchor: .bottom)
                            .padding(.bottom, 49)
                    }
                }
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color(red: 151/255, green: 151/255, blue: 151/255, opacity: 0.1), radius: 4, x: 2, y: 2)
    }
}

struct ListActivityView_Previews: PreviewProvider {
    static var previews: some View {
        
        let activityModel: ActivityModel = {
            let model = ActivityModel()
            model.updateActivityForTestingOnly()
            return model
        }()
        
        Group {
            ListActivityView(activity: activityModel.activies[0])
                .previewLayout(.sizeThatFits)
            
            ListActivityView(activity: activityModel.activies[2])
                .previewLayout(.sizeThatFits)
            
            ListActivityView(activity: activityModel.activies[3])
                .previewLayout(.sizeThatFits)
        }
    }
}
