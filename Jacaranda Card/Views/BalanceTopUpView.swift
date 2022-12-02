//
//  BalanceTopUpView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 2/12/2022.
//

import SwiftUI

struct BalanceTopUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    @State var topUpAmount = ""
    @FocusState private var topUpAmountKeyboardFocused: Bool
    
    var body: some View {
        VStack {
            // MARK: Top Up Amount Section
            VStack(alignment: .leading, spacing: 11) {
                Text("Enter the amount")
                    .font(Font.custom("DMSans-Medium", size: 14))
                    .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                    .padding(.top, 15)
                    .padding(.leading, 30)
      
                HStack(spacing: 0) {
                    Text("$")
                        .font(Font.custom("DMSans-Medium", size: 24))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                        .padding(.bottom, 16)
                        .padding(.leading, 30)
                    
                    TextField("0.00", text: $topUpAmount)
                        .modifyInputCurrency(value: $topUpAmount)
                        .font(Font.custom("DMSans-Medium", size: 24))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                        .padding(.bottom, 16)
                        .padding(.leading, 12)
                        .keyboardType(.numberPad)
                        .focused($topUpAmountKeyboardFocused)
                }
            }
            .background(Color(red: 252/255, green: 252/255, blue: 252/255))
            .padding(.top, 39)
            .padding(.bottom, 55)
            
            // MARK: Next Button Section
            Button {
                print("Top Up")
                
            } label: {
                if topUpAmount == "" || topUpAmount == "0.00" {
                    Image("nextButtonInactive")
                        .cornerRadius(8)
                }
                else {
                    Image("nextButton")
                        .cornerRadius(8)
                }
            }
            .disabled({
                if topUpAmount == "" || topUpAmount == "0.00" {
                    return true
                }
                else {
                    return false
                }
            }())
            
            Spacer()
        }
        .background(Color(red: 246/255, green: 246/255, blue: 246/255))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Top up Balance")
                        .font(Font.custom("DMSans-Bold", size: 16))
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
            topUpAmountKeyboardFocused = false
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
        }))
    }
}

struct BalanceTopUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BalanceTopUpView()
        }
    }
}
