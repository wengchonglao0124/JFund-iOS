//
//  ActivityDetailedView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 30/10/2022.
//

import SwiftUI

struct ActivityDetailedView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var activity: Activity
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Top Section
            VStack(spacing: 0) {
                
                VStack {
                    if activity.imageName.first == "#" {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .fill(Color(hex: activity.imageName)!)
                            
                            Text(activity.username.prefix(1))
                                .font(Font.custom("DMSans-Bold", size: 22))
                                .foregroundColor(.white)
                        }
                        .frame(width: 50, height: 50, alignment: .center)
                        .cornerRadius(30)
                    }
                    else if activity.imageName == "topUpIcon" {
                        
                        Image(activity.imageName)
                            .frame(width: 50, height: 50, alignment: .center)
                            .cornerRadius(12)
                    }
                    else {
                        Image("apple")
                            .frame(width: 50, height: 50, alignment: .center)
                            .cornerRadius(12)
                    }
                }
                .padding(.vertical, 22)
                
                if activity.type == "top-up" {
                    Text(activity.username)
                        .font(Font.custom("DMSans-Bold", size: 16))
                        .foregroundColor(Color("activityTextColor"))
                        .padding(.bottom, 18)
                } else if activity.type == "receive" {
                    Text("From \(activity.username)")
                        .font(Font.custom("DMSans-Bold", size: 16))
                        .foregroundColor(Color("activityTextColor"))
                        .padding(.bottom, 18)
                } else {
                    // type = "pay"
                    Text("To \(activity.username)")
                        .font(Font.custom("DMSans-Bold", size: 16))
                        .foregroundColor(Color("activityTextColor"))
                        .padding(.bottom, 18)
                }
                
                if activity.type == "receive" || activity.type == "top-up" {
                    Text(activity.amountString)
                        .font(Font.custom("DMSans-Bold", size: 16))
                        .foregroundColor(Color("activityAddAmountColor"))
                }
                else {
                    Text(activity.amountString)
                        .font(Font.custom("DMSans-Bold", size: 16))
                        .foregroundColor(Color("activityTextColor"))
                }
            }
            .padding(.bottom, 29)
            
            // MARK: Bottom Section
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    Text("Transaction time")
                        .font(Font.custom("DMSans-Medium", size: 12))
                        .foregroundColor(Color("activitySubtitleColor"))
                    
                    Spacer()
                    
                    VStack (alignment: .leading, spacing: 0) {
                        
                        let weekDay = activity.date.formatted(.dateTime.weekday(.wide))
                        Text(weekDay + ", " + DateService.getDateString(format: "dd MMM yyyy", date: activity.date))
                            .font(Font.custom("DMSans-Medium", size: 12))
                            .foregroundColor(Color("activityDataColor"))
                        
                        Text("\(DateService.getDateString(format: "HH:mm", date: activity.date)) (AEST/AEDT)")
                            .font(Font.custom("DMSans-Medium", size: 12))
                            .foregroundColor(Color("activityDataColor"))
                    }
                }
                .padding(.top, 17)
                .padding(.bottom, 26)
                
                HStack {
                    Text("Receipt number")
                        .font(Font.custom("DMSans-Medium", size: 12))
                        .foregroundColor(Color("activitySubtitleColor"))
                    
                    Spacer()
                    
                    Text("\(activity.receipt)")
                        .font(Font.custom("DMSans-Medium", size: 12))
                        .foregroundColor(Color("activityDataColor"))
                }
                .padding(.bottom, 16)
            }
            .padding(.leading, 25)
            .padding(.trailing, 19)
            .background(Color(red: 252/255, green: 252/255, blue: 252/255))
            
            Spacer()
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}

struct ActivityDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        
        let activityModel: ActivityModel = {
            let model = ActivityModel()
            model.updateActivityForTestingOnly()
            return model
        }()
        
        Group {
            NavigationView {
                ActivityDetailedView(activity: activityModel.activies[0])
            }
            
            NavigationView {
                ActivityDetailedView(activity: activityModel.activies[2])
            }
            
            NavigationView {
                ActivityDetailedView(activity: activityModel.activies[3])
            }
        }
    }
}
