//
//  HomeBusinessPartnerHeaderView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 23/7/2022.
//

import SwiftUI

struct HomeBusinessPartnerHeaderView: View {
    
    @State var selectedTab = "restaurant"
    
    // For Segment Tab Slide Animation
    @Namespace var animation
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Business Partner")
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundColor(Color("businessPartnerTextColor"))
                .padding([.top, .bottom], 16)
            
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
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
    }
}

struct HomeBusinessPartnerHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBusinessPartnerHeaderView()
            .previewLayout(.sizeThatFits)
    }
}
