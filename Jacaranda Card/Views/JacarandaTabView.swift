//
//  JacarandaTabView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 21/7/2022.
//

import SwiftUI

struct JacarandaTabView: View {
    
    @State var selectionIndex = 1
    let textColorSelected = Color("tabViewColorSelected")
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("tabBarColor"))
    }
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $selectionIndex) {
                
                // MARK: Home View
                GeometryReader { geo in
                    JacarandaHomeView(screenHeight: geo.size.height, offsetPosition: geo.frame(in: .global).minY, tabViewSelectionIndex: $selectionIndex)
                }
                .tabItem({
                    VStack {
                        if selectionIndex == 1 {
                            Image("homeSelected")
                        }
                        else {
                            Image("home")
                        }
                        Text("Home")
                            .font(Font.custom("DMSans-Bold", size: 12))
                    }
                })
                .tag(1)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
                // MARK: Activity View
                JacarandaActivityView(activities: ActivityModel().activies)
                    .tabItem({
                        VStack {
                            if selectionIndex == 2 {
                                Image("activitySelected")
                            }
                            else {
                                Image("activity")
                            }
                            Text("Activity")
                                .font(Font.custom("DMSans-Bold", size: 12))
                        }
                    })
                    .tag(2)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                // MARK: Profile View
                JacarandaProfileView(userName: "UserName", carID: "1234 5678 3657 5623")
                    .tabItem({
                        VStack {
                            if selectionIndex == 3 {
                                Image("profileSelected")
                            }
                            else {
                                Image("profile")
                            }
                            Text("Profile")
                                .font(Font.custom("DMSans-Bold", size: 12))
                        }
                    })
                    .tag(3)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
        .accentColor(textColorSelected)
    }
}

struct JacarandaTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JacarandaTabView()
            
            JacarandaTabView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
