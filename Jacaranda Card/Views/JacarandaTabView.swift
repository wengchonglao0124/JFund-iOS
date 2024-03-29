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
    
    @StateObject var userDataVM = UserDataViewModel()
    @StateObject var activityVM = ActivityModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("tabBarColor"))
    }
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $selectionIndex) {
                
                // MARK: Home View
                JacarandaHomeView(tabViewSelectionIndex: $selectionIndex)
                    .environmentObject(userDataVM)
                    .environmentObject(activityVM)
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
                
                // MARK: Shop View
                JacarandaShopView()
                    .tabItem({
                        VStack {
                            if selectionIndex == 2 {
                                Image("shopSelected")
                            }
                            else {
                                Image("shop")
                            }
                            Text("Shop")
                                .font(Font.custom("DMSans-Bold", size: 12))
                        }
                    })
                    .tag(2)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                // MARK: Activity View
                JacarandaActivityView(tabViewSelectionIndex: selectionIndex)
                    .environmentObject(userDataVM)
                    .environmentObject(activityVM)
                    .tabItem({
                        VStack {
                            if selectionIndex == 3 {
                                Image("activitySelected")
                            }
                            else {
                                Image("activity")
                            }
                            Text("Activity")
                                .font(Font.custom("DMSans-Bold", size: 12))
                        }
                    })
                    .tag(3)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                // MARK: Profile View
                JacarandaProfileView()
                    .environmentObject(userDataVM)
                    .tabItem({
                        VStack {
                            if selectionIndex == 4 {
                                Image("profileSelected")
                            }
                            else {
                                Image("profile")
                            }
                            Text("Profile")
                                .font(Font.custom("DMSans-Bold", size: 12))
                        }
                    })
                    .tag(4)
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
