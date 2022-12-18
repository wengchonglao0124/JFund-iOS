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
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    var payVM = PayViewModel()
    
    var body: some View {
        ZStack {
            // MARK: Main View
            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    VStack {
                        Text(userDataVM.userName)
                            .font(Font.custom("DMSans-Medium", size: 16))
                            .padding(.top, 53)
                            .padding(.bottom, 18)
                        Text(userDataVM.getUserID())
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
        .task {
          do {
              print("Connecting to server")
              
              for try await message in payVM.stream! {
                  switch message {
                  case .string(let text):
                      print(text)
                  case .data(let data):
                      print(data)
                  @unknown default:
                      print("Oops something didn't go right")
                  }
              }
              
          } catch {
              print("Oops something didn't go right")
          }
        }
    }
}

struct JacarandaPayView_Previews: PreviewProvider {
    static var previews: some View {
        
        let data = "{\"image\":\"#a2d2ff\",\"UserName\":\"billylao\",\"RefreshToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzEzMzk3MDEsImp0aSI6InJlZnJlc2hUb2tlbiJ9.KJSENeGG5vaCMfWh01irNlsUPgvU4jd0_2vB_Xlnwps\",\"UserID\":\"4468674852519615\",\"AccessToken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzA4MjEzMDEsImp0aSI6ImFjY2Vzc1Rva2VuIn0.4Nj-KpJUznS86VSHaRn4NlgCZVJiqoe6DT-7IkKAk0M\",\"info\":\"1\"}"
        
        let credentials = Credentials.decode(data)
        let isSuccess = KeychainService.saveCredentials(credentials)
        
        if isSuccess {
            let userDataVM = UserDataViewModel()
            
            let userData = UserData.decode(data)
            NavigationView {
                JacarandaPayView()
            }
            .environmentObject(userDataVM)
            .onAppear(perform: {
                UserDefaults.standard.set(userData.UserName, forKey: "userName")
            })
        }
    }
}
