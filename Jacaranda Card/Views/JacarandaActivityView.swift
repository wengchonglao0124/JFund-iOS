//
//  JacarandaActivityView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 21/7/2022.
//

import SwiftUI

struct JacarandaActivityView: View {
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    @EnvironmentObject var activityVM: ActivityModel
    
    var tabViewSelectionIndex: Int
    
    var activities: [Activity] {
        activityVM.activies
    }
    var activitiesSorted: [Activity] {
        activities.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
    }
    
    // Search Text
    @State var searchQuery = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: Title Section
            Text("Activity")
                .font(Font.custom("DMSans-Bold", size: 18))
                .padding(.leading, 22)
                .padding(.bottom, 15)
            
            VStack {
                // MARK: Searching Section
                HStack(spacing: 0) {
                    Image("baseSearch")
                        .padding(9)
                        .frame(height: 34)
                        .background(Color(red: 233/255, green: 233/255, blue: 234/255))

                    TextField("Search...", text: $searchQuery)
                        .font(Font.custom("DMSans-Medium", size: 14))
                        .cornerRadius(8)
                        .padding(.vertical, 7)
                        .frame(height: 34)
                        .background(Color(red: 233/255, green: 233/255, blue: 234/255))

                    Image("otherFilter")
                        .padding(.leading, 17)
                        .frame(height: 34)
                        .background(Color(red: 252/255, green: 252/255, blue: 252/255, opacity: 0.8))

                }
                .padding(.horizontal, 18)
                .padding(.top, 15)
                
                // MARK: Activities Section
                ScrollView {
                    
                    PullToRefreshView(coordinateSpaceName: "pullToRefreshActivityView") {
                        // do your stuff when pulled
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()
                        
                        activityVM.updateActivityRecords(accessToken: userDataVM.getAccessToken()!)
                    }
                    
                    LazyVStack(spacing: 0) {
                        
                        // activity collection by date
                        let activitiesList = DateService.getActivityCollectionByDate(activityList: activitiesSorted)
                        
                        // sorted date list from dictionary keys
                        let dateList: [String] = {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "MMM yyyy"
                            
                            let sortedList = Array(activitiesList.keys).sorted(by: { formatter.date(from: $0)! > formatter.date(from: $1)!  })
                            return sortedList
                        }()
                        
                        // looping for each date 
                        ForEach(dateList, id: \.self) { date in
                            Section(header:
                                Text(date)
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                                .padding(.vertical, 16)
                            ) {
                                // looping for each activity
                                ForEach(activitiesList[date]!) { activity in
                                    ListActivityView(activity: activity)
                                        .padding(.bottom, 12)
                                }
                            }
                        }
                        
                        if tabViewSelectionIndex == 3 {
                            if activities.count >= 10 {
                                Text("")
                                    .onAppear(perform: {
                                        print("Scroll to bottom to update activities")
                                        
                                        activityVM.updateActivityMoreRecords(accessToken: userDataVM.getAccessToken()!)
                                    })
                            }
                        }
                    }
                }
                .padding(.horizontal, 15)
                .coordinateSpace(name: "pullToRefreshActivityView")
            }
            .background(Color(red: 252/255, green: 252/255, blue: 252/255, opacity: 0.8))
        }
        .padding(.top, 31.5)
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
    }
}

struct JacarandaActivityView_Previews: PreviewProvider {
    static var previews: some View {
        
        let activityModel: ActivityModel = {
            let model = ActivityModel()
            model.updateActivityForTestingOnly()
            return model
        }()
        
        Group {
            JacarandaActivityView(tabViewSelectionIndex: 4)
                .environmentObject(activityModel)
            
            JacarandaActivityView(tabViewSelectionIndex: 4)
                .environmentObject(activityModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}





