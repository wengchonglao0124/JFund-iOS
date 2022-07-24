//
//  HomeActivityView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import SwiftUI

struct HomeActivityView: View {
    
    @State var activityModel: ActivityModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Recent Activity")
                .font(.system(size: 14))
                .foregroundColor(Color("activityTextColor"))
                .fontWeight(.bold)
                .padding(.vertical, 16)
                .padding(.leading, 24)
              
            VStack(alignment: .leading) {
                if activityModel.activies.isEmpty {
                    // MARK: Recent Activity Empty
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Image("noTransactionYet")
                                .padding(.bottom, 16)
                            Text("No Transaction yet")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .padding(.bottom, 7)
                            Text("Go make your first Payment :)")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .padding(.bottom, 29)
                        }
                        Spacer()
                    }
                }
                else {
                    let activities = activityModel.activies
                    let activitiesList = activities.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
                    
                    if activities.count <= 3 {
                        // MARK: Recent Activities less than or equal to 3
                        ForEach(activitiesList) { activity in
                            ListActivityView(activity: activity)
                                .padding(.bottom, 12)
                        }
                    }
                    else {
                        // MARK: Recent Activities greater than 3
                        VStack {
                            ForEach(0..<3) { index in
                                ListActivityView(activity: activitiesList[index])
                                    .padding(.bottom, 12)
                            }
                            Text("Show all")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 82/255, green: 36/255, blue: 121/255))
                                .padding(.top, 17.5)
                                .padding(.bottom, 11.5)
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
        }
        .background(Color("recentActivitySectionColor"))
    }
}

struct HomeActivityView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Recent Activity Empty
        let activityModelEmpty: ActivityModel = {
            let model = ActivityModel()
            model.activies = [Activity]()
            return model
        }()
        HomeActivityView(activityModel: activityModelEmpty)
            .previewLayout(.sizeThatFits)
        
        // Recent Activities greater than 3
        let activityModel = ActivityModel()
        HomeActivityView(activityModel: activityModel)
            .previewLayout(.sizeThatFits)
        
        // Recent Activities equal to 3
        let activityModelEqualToThree: ActivityModel = {
            let model = ActivityModel()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            return model
        }()
        HomeActivityView(activityModel: activityModelEqualToThree)
            .previewLayout(.sizeThatFits)
        
        // Recent Activities less than 3
        let activityModelLessThanThree: ActivityModel = {
            let model = ActivityModel()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            model.activies.removeLast()
            return model
        }()
        HomeActivityView(activityModel: activityModelLessThanThree)
            .previewLayout(.sizeThatFits)
    }
}
