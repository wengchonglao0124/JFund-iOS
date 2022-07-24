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
        
        TabView(selection: $selectionIndex) {
            
            // MARK: Home View
            GeometryReader { geo in
                JacarandaHomeView(screenHeight: geo.size.height, offsetPosition: geo.frame(in: .global).minY)
            }
            .tabItem({
                VStack {
                    if selectionIndex == 1 {
                        Image("homeSelected")
                        Text("Home")
                    }
                    else {
                        Image("home")
                        Text("Home")
                    }
                }
            })
            .tag(1)
            
            // MARK: Wallet View
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
                    }
                })
                .tag(2)
            
            // MARK: Profile View
            JacarandaProfileView()
                .tabItem({
                    VStack {
                        if selectionIndex == 3 {
                            Image("profileSelected")
                        }
                        else {
                            Image("profile")
                        }
                        Text("Profile")
                    }
                })
                .tag(3)
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
