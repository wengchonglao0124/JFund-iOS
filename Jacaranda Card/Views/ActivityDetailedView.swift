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
                Image(activity.imageName)
                    .frame(width: 50, height: 50, alignment: .center)
                    .cornerRadius(12)
                    .padding(.vertical, 22)
                
                Text("To \(activity.name)")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(Color("activityTextColor"))
                    .padding(.bottom, 18)
                
                if activity.amount >= 0 {
                    Text(activity.amountString)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color("activityAddAmountColor"))
                }
                else {
                    Text(activity.amountString)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color("activityTextColor"))
                }
            }
            .padding(.bottom, 29)
            
            // MARK: Bottom Section
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    Text("Transaction time")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color("activitySubtitleColor"))
                    
                    Spacer()
                    
                    VStack (alignment: .leading, spacing: 0) {
                        
                        let weekDay = activity.date.formatted(.dateTime.weekday(.wide))
                        Text(weekDay + ", " + DateService.getDateString(format: "dd MMM yyyy", date: activity.date))
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(Color("activityDataColor"))
                        
                        Text("18:24 (AEST/AEDT)")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(Color("activityDataColor"))
                    }
                }
                .padding(.top, 17)
                .padding(.bottom, 26)
                
                HStack {
                    Text("Receipt number")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color("activitySubtitleColor"))
                    
                    Spacer()
                    
                    Text("1234 5678 0000")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
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
        
        let activityModel = ActivityModel()
        
        NavigationView {
            ActivityDetailedView(activity: activityModel.activies[0])
        }
    }
}
