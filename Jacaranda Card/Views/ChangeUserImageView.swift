//
//  ChangeUserImageView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 13/12/2022.
//

import SwiftUI

struct ChangeUserImageView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    let colorSet = ["#cdb4db", "#ffafcc", "#ffcaca", "#fb6f92", "#449dd1", "#bccef8", "#a2d2ff", "#74c69d"]
    
    var username: String
    @State var userImage: String
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    @State var isLoading = false
    @State var isFinish = false
    
    @State var invalidMessages = ""
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color(hex: userImage)!)
                        .frame(width: 63, height: 63)
                    Text(username.prefix(1))
                        .font(Font.custom("DMSans-Bold", size: 32))
                        .foregroundColor(.white)
                }
                .padding(.top, 30)
                .padding(.bottom, 60)
                
                HStack {
                    Spacer()
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 40) {
                        
                        ForEach(colorSet, id: \.self) { value in
                            
                            Button {
                                userImage = value
                                
                            } label: {
                                Circle()
                                    .fill(Color(hex: value)!)
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    Spacer()
                }
                .padding(.bottom, 50)
                .disabled(isLoading)
                
                if !invalidMessages.isEmpty {
                    HStack {
                        Spacer()
                        Text(invalidMessages)
                            .font(Font.custom("DMSans-Medium", size: 10))
                            .foregroundColor(.red)
                        Spacer()
                    }
                    .padding(.bottom, 5)
                }
                
                Button {
                    print("Save user image")
                    isLoading = true
                    invalidMessages = ""
                    
                    userDataVM.changeUserImage(newUserImage: userImage) { success in
                        
                        if success {
                            isFinish = true
                        }
                        else {
                            invalidMessages = "Please try again."
                        }
                        isLoading = false
                    }
                    
                    
                } label: {
                    Image("saveButton")
                }
                .disabled(isLoading)
                
                Spacer()
            }
            
            LoadingView(message: "Loading", isLoading: $isLoading)
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Icon color")
                        .font(Font.custom("DMSans-Bold", size: 16))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                dismiss()
            }
        }))
        .onChange(of: isFinish) { newValue in
            dismiss()
        }
    }
}

struct ChangeUserImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChangeUserImageView(username: "L", userImage: "#74c69d")
        }
    }
}
