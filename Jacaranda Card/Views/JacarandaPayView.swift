//
//  JacarandaPayView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 31/7/2022.
//

import SwiftUI

struct JacarandaPayView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    @State var isPresentingSettingView = false
    
    @State var username: String
    var carID: String
    
    var body: some View {
        ZStack {
            // MARK: Main View
            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    VStack {
                        Text(username)
                            .font(Font.custom("DMSans-Medium", size: 16))
                            .padding(.top, 53)
                            .padding(.bottom, 18)
                        Text(carID)
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .padding(.bottom, 19)
                        Image("qrCode")
                        Text("QR code automatically renew every minute")
                            .font(Font.custom("DMSans-Regular", size: 12))
                            .foregroundColor(Color(red: 89/255, green: 89/255, blue: 89/255))
                            .padding(.vertical, 26.2)
                        Spacer()
                    }
                    .frame(height: 423)
                    Spacer()
                }
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal, 17.5)
                .padding(.top, 33)
                Spacer()
            }
            .background(Color(red: 107/255, green: 53/255, blue: 160/255))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Scan to Pay")
                            .font(Font.custom("DMSans-Bold", size: 16))
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            isPresentingSettingView = true
                        } label: {
                            Text("...")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.trailing, 19)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image("backArrowWhite")
                    .padding(0)
            })
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    self.mode.wrappedValue.dismiss()
                }
            }))
            
            // MARK: Popup View
            PaySettingView(isPresentingSettingView: $isPresentingSettingView)
        }
    }
}

struct JacarandaPayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JacarandaPayView(username: "Lilyxoxo", carID: "1234 5678 3657 5623")
        }
    }
}
