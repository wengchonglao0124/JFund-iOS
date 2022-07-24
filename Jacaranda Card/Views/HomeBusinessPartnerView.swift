//
//  HomeBusinessPartnerView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import SwiftUI

struct HomeBusinessPartnerView: View {
    
    @State var selectedTab = "restaurant"
    @State var businessPartnerModel: BusinessPartnerModel
    
    var screenHeight: CGFloat
    
    // For Segment Tab Slide Animation
    @Namespace var animation
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Business Partner")
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundColor(Color("businessPartnerTextColor"))
                .padding(.top, 16)
                .padding(.bottom, 20)
                .padding(.leading, 24)
            
            VStack {
                // MARK: Picker Section
                HStack {
                    // MARK: Restaurant Tab
                    Text("Restaurant")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .padding(.vertical, 6.5)
                        .padding(.horizontal, 18)
                        .foregroundColor({
                            if selectedTab == "restaurant" {
                                return Color("businessPartnerContentColor")
                            }
                            else {
                                return Color.black
                            }
                        }())
                        .background(
                            ZStack {
                                if selectedTab == "restaurant" {
                                    Color("businessPartnerPickerColor")
                                        .cornerRadius(20)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        )
                        .onTapGesture {
                            withAnimation(.interactiveSpring(
                                response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                    selectedTab = "restaurant"
                                }
                        }
                    
                    // MARK: Beauty Tab
                    Text("Beauty")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .padding(.vertical, 6.5)
                        .padding(.horizontal, 18)
                        .foregroundColor({
                            if selectedTab == "beauty" {
                                return Color("businessPartnerContentColor")
                            }
                            else {
                                return Color.black
                            }
                        }())
                        .background(
                            ZStack {
                                if selectedTab == "beauty" {
                                    Color("businessPartnerPickerColor")
                                        .cornerRadius(20)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        )
                        .onTapGesture {
                            withAnimation(.interactiveSpring(
                                response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                    selectedTab = "beauty"
                                }
                        }
                    
                    // MARK: Tourism Tab
                    Text("Tourism")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .padding(.vertical, 6.5)
                        .padding(.horizontal, 18)
                        .foregroundColor({
                            if selectedTab == "tourism" {
                                return Color("businessPartnerContentColor")
                            }
                            else {
                                return Color.black
                            }
                        }())
                        .background(
                            ZStack {
                                if selectedTab == "tourism" {
                                    Color("businessPartnerPickerColor")
                                        .cornerRadius(20)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        )
                        .onTapGesture {
                            withAnimation(.interactiveSpring(
                                response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                    selectedTab = "tourism"
                                }
                        }
                }
                
                VStack {
                    TabView(selection: $selectedTab) {

                        // MARK: Restaurant List
                        ScrollView(showsIndicators: false) {
                            LazyVStack {
                                ForEach(businessPartnerModel.restaurants) { restaurant in
                                    ListBusinessPartnerView(businessPartner: restaurant)
                                }
                            }
                        }
                        .tag("restaurant")

                        // MARK: Beauty List
                        ScrollView(showsIndicators: false) {
                            LazyVStack {
                                ForEach(businessPartnerModel.beauties) { beauty in
                                    ListBusinessPartnerView(businessPartner: beauty)
                                }
                            }
                        }
                        .tag("beauty")

                        // MARK: Tourism List
                        ScrollView(showsIndicators: false) {
                            LazyVStack {
                                ForEach(businessPartnerModel.tourisms) { tourism in
                                    ListBusinessPartnerView(businessPartner: tourism)
                                }
                            }
                        }
                        .tag("tourism")
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
            .padding(.horizontal, 27.7)
        }
        .frame(height: screenHeight)
        .background(Color("homeBusinessPartnerSectionColor"))
    }
}

struct HomeBusinessPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScrollView(showsIndicators: false) {
                HomeBusinessPartnerView(businessPartnerModel: BusinessPartnerModel(), screenHeight: UIScreen.main.bounds.height)
            }
            //.previewLayout(.sizeThatFits)
            
            ScrollView(showsIndicators: false) {
                HomeBusinessPartnerView(businessPartnerModel: BusinessPartnerModel(), screenHeight: UIScreen.main.bounds.height)
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}

