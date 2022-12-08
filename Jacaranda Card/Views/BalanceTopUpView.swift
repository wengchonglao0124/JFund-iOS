//
//  BalanceTopUpView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 2/12/2022.
//

import SwiftUI

struct BalanceTopUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    var accessToken: String
    
    @State var topUpAmount = ""
    @FocusState private var topUpAmountKeyboardFocused: Bool
    
    var stripeTopUpView = StripeTopUpView()
    @State var isLoading = false
    @State var invalidMessages = ""
    @State var isPaying = false
    @State var paidSuccess = false
    @State var isFinish = false
    
    var body: some View {
        ZStack {
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
                            .disabled(isLoading)
                    }
                }
                .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                .padding(.top, 39)
                .padding(.bottom, 55)
                
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
                
                // MARK: Next Button Section
                Button {
                    invalidMessages = ""
                    topUpAmountKeyboardFocused = false
                    
                    let amount = Float(topUpAmount)!
                    if amount >= 0.5 {
                        isLoading = true
                        stripeTopUpView.fetchPaymentIntent(accessToken: accessToken, amounts: topUpAmount) { success in
                            
                            if success {
                                isPaying = true
                                
                            }
                            else {
                                invalidMessages = "Please try again."
                            }
                            isLoading = false
                        }
                    }
                    else {
                        invalidMessages = "Minimum top-up amount is $ 0.50"
                    }
                    
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
                    if topUpAmount == "" || topUpAmount == "0.00" || isLoading {
                        return true
                    }
                    else {
                        return false
                    }
                }())
                
                stripeTopUpView
                Spacer()
            }
            //.disabled(isLoading)
            
            LoadingView(message: "Loading", isLoading: $isLoading)
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
            dismiss()
        }){
            Image("backArrowBlack")
                .padding(0)
        })
        .onTapGesture {
            topUpAmountKeyboardFocused = false
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                dismiss()
            }
        }))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                topUpAmountKeyboardFocused = true
            }
        }
        .onChange(of: isPaying) { newValue in
            if isPaying {
                DispatchQueue.main.async {
                    stripeTopUpView.pay() { success in
                        if success {
                            isPaying = false
                            paidSuccess = true
                            print("Finish paying")
                        }
                        else {
                            isPaying = false
                            print("fail to pay")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $paidSuccess) {
            SuccessPaymentView(subtitle: "Top up sucessfully", amount: String(topUpAmount), message: "", isPresenting: $paidSuccess, finishedProcess: $isFinish)
        }
        .onChange(of: isFinish) { newValue in
            dismiss()
        }
    }
}

struct BalanceTopUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BalanceTopUpView(accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiaWxseWxhbzg4OEBnbWFpbC5jb20iLCJleHAiOjE2NzA0OTY3NzMsImp0aSI6ImFjY2Vzc1Rva2VuIn0.qFBINXPMAihxjEp3UuxjOsJLNv_Z1-pyf3KmMMjN2fY")
        }
    }
}
