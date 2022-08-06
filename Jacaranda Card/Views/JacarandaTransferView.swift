//
//  JacarandaTransferView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 31/7/2022.
//

import SwiftUI

struct JacarandaTransferView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    @State var transferID = ""
    @State var foundUser = false
    @State var transferAmount = ""
    
    @FocusState private var userIDKeyboardFocused: Bool
    
    var body: some View {
        VStack {
            if foundUser {
                HStack(spacing: 5) {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color(red: 215/255, green: 199/255, blue: 228/255))
                                .frame(width: 63, height: 63)
                        }
                    
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Irene qq")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                            Text(transferID.applyPattern())
                                .font(.system(size: 14))
                                .fontWeight(.regular)
                                .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                        }
                        .padding(.leading, 10)
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.vertical, 15.5)
                    .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                }
                .padding(.top, 30)
                .animation(.easeInOut, value: foundUser)
                
                VStack(alignment: .leading, spacing: 11) {
                    Text("Enter the amount")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                        .padding(.top, 15)
                        .padding(.leading, 30)
                    
                    TextField("", text: $transferAmount)
                        .font(.system(size: 24))
                        .font(.title.weight(.medium))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                        .padding(.bottom, 16)
                        .padding(.leading, 30)
                        .keyboardType(.numberPad)
                        .focused($userIDKeyboardFocused)
                }
                .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                .padding(.top, 28)
                .padding(.bottom, 81)
                .animation(.easeInOut, value: foundUser)
                
                Button {
                    userIDKeyboardFocused = false
                } label: {
                    Image("continueButton")
                        .cornerRadius(8)
                }
            }
            else {
                VStack(alignment: .leading, spacing: 11) {
                    Text("Enter the user ID")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                        .padding(.top, 15)
                        .padding(.leading, 30)
                    
                    TextField("", text: $transferID)
                        .font(.system(size: 24))
                        .font(.title.weight(.medium))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                        .padding(.bottom, 16)
                        .padding(.leading, 30)
                        .keyboardType(.numberPad)
                        .focused($userIDKeyboardFocused)
                }
                .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                .padding(.top, 28)
                .padding(.bottom, 43)
                .animation(.easeInOut, value: foundUser)
                
                Button {
                    userIDKeyboardFocused = false
                    foundUser = true
                } label: {
                    Image("nextButton")
                        .cornerRadius(8)
                }
            }
            Spacer()
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Transfer to")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .onTapGesture {
            userIDKeyboardFocused = false
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}


extension String {
    func applyPattern(pattern: String = "#### #### #### ####", replacmentCharacter: Character = "#") -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: self)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}


struct JacarandaTransferView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JacarandaTransferView()
        }
    }
}
