//
//  TestingPromotionView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 2/12/2022.
//

import SwiftUI

struct TestingPromotionView: View {
    
    var companyName: String
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var title: String
    var description: String
    var endDate: Date
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    // MARK: Company Image Section
                    Image("companyTestingImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 218)
                        .clipped()
                        .cornerRadius(12)
                        .padding(.top, 22)
                        .padding(.bottom, 24)
                    
                    // MARK: Title Section
                    VStack {
                        VStack(alignment: .leading, spacing: 13) {
                            HStack {
                                Text(title)
                                    .font(Font.custom("DMSans-Bold", size: 16))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            
                            Text(companyName)
                                .font(Font.custom("DMSans-Medium", size: 14))
                                .foregroundColor(Color(red: 122/255, green: 126/255, blue: 128/255))
                        }
                        .padding(.top, 18)
                        .padding(.bottom, 16)
                        .padding(.horizontal, 21)
                    }
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                    .cornerRadius(12)
                    .padding(.bottom, 22)
                    
                    // MARK: Expired Date Section
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 11) {
                                Text("Expiry date")
                                    .font(Font.custom("DMSans-Bold", size: 12))
                                    .foregroundColor(Color(red: 122/255, green: 126/255, blue: 128/255))
                                
                                Text(DateService.getDateString(format: "dd/MM/yyyy", date: endDate))
                                    .font(Font.custom("DMSans-Medium", size: 14))
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        .padding(.top, 18)
                        .padding(.bottom, 21)
                        .padding(.leading, 21)
                    }
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                    .cornerRadius(12)
                    .padding(.bottom, 22)
                    
                    // MARK: Description Section
                    VStack {
                        VStack(alignment: .leading, spacing: 11) {
                            Text("Description")
                                .font(Font.custom("DMSans-Bold", size: 12))
                                .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                            
                            HStack {
                                Text(description)
                                    .font(Font.custom("DMSans-Medium", size: 12))
                                    .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                                Spacer()
                            }
                        }
                        .padding(.top, 18)
                        .padding(.bottom, 21)
                        .padding(.leading, 21)
                        .padding(.trailing, 18)
                    }
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                    .cornerRadius(12)
                    .padding(.bottom, 22)
                    
                    Spacer()
                }
                .frame(width: 320)
                Spacer()
            }
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

struct TestingPromotionView_Previews: PreviewProvider {
    static var previews: some View {
        TestingPromotionView(companyName: "Pizza Hut", title: "Hawaiian Pizza & Ice cream 10% off in Valentines day ", description: "Pizza Hut Hawaiian Pizza & Ice cream 10% off in 14/02 Valentines day (not avaliable with any other deals)\n\nOnly in Valentines day!! ", endDate: Date())
    }
}
