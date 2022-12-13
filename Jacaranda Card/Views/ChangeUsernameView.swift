//
//  ChangeUsernameView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 13/12/2022.
//

import SwiftUI

struct ChangeUsernameView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    @State var newUsername = ""
    @FocusState private var userNameKeyboardFocused: Bool
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    @State var isLoading = false
    @State var isFinish = false
    
    @State var invalidMessages = ""
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: New Username Input Section
                VStack {
                    TextField("Please enter username", text: $newUsername)
                        .font(Font.custom("DMSans-Medium", size: 14))
                        .foregroundColor({
                            if newUsername.isEmpty {
                                return Color(red: 151/255, green: 151/255, blue: 151/255)
                            }
                            else {
                                return Color("FieldTextColor")
                            }
                        }())
                        .keyboardType(.default)
                        .focused($userNameKeyboardFocused)
                        .padding(.leading, 21)
                        .padding(.vertical, 19)
                        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                        .disabled(isLoading)
                }
                .padding(.top, 35)
                .padding(.bottom, 40)
                .onTapGesture {
                    userNameKeyboardFocused = true
                }
                
                // MARK: Invalid Messages Section
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
                
                // MARK: Save Username Button Section
                Button {
                    print("Save username")
                    isLoading = true
                    invalidMessages = ""
                    
                    userDataVM.changeUsername(newUsername: newUsername) { success in
                        if success {
                            isFinish = true
                        }
                        else {
                            invalidMessages = "Please try again."
                        }
                        isLoading = false
                    }
                    
                } label: {
                    if newUsername.isEmpty {
                        Image("saveButtonInactive")
                    }
                    else {
                        Image("saveButton")
                    }
                }
                .disabled(newUsername.isEmpty || isLoading)
                
                Spacer()
            }
            
            LoadingView(message: "Loading", isLoading: $isLoading)
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Username")
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
        .onTapGesture {
            if userNameKeyboardFocused {
                userNameKeyboardFocused = false
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                userNameKeyboardFocused = true
            }
        }
        .onChange(of: isFinish) { newValue in
            UserDefaults.standard.set(newUsername, forKey: "userName")
            dismiss()
        }
    }
}

struct ChangeUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ChangeUsernameView()
            }
            
            NavigationView {
                ChangeUsernameView()
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        }
    }
}
