//
//  JacarandaTransferView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 31/7/2022.
//

import SwiftUI

struct JacarandaTransferView: View {
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    @State var transferID = ""
    @State var foundUser = false
    @State var transferAmount = ""
    
    @State var isPresentingConfirmPayment = false
    @State var isPresentingSuccessPayment = false
    @State var isLoading = false
    @State var finishedTransfer = false
    @State var invalidTransferID = false
    @State var isPresentingIDInformation = false
    @State var isConfirm = false
    
    @State var isCancel = false
    @State var isConfirmingPin = false
    
    @FocusState private var userIDKeyboardFocused: Bool
    @FocusState private var transferAmountKeyboardFocused: Bool
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    @State var invalidMessages = ""
    
    @StateObject var transferVM = TransferViewModel()
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    @State var fid = ""
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: Found Payee Section
                if foundUser {
                    VStack {
                        // MARK: Payee Section
                        HStack(spacing: 5) {
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(Color(hex: transferVM.payeeImage)!)
                                        .frame(width: 63, height: 63)
                                    
                                    Text(transferVM.payeeName.prefix(1))
                                        .font(Font.custom("DMSans-Bold", size: 32))
                                        .foregroundColor(.white)
                                }
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(transferVM.payeeName)
                                        .font(Font.custom("DMSans-Bold", size: 18))
                                    Text(transferID.applyPattern())
                                        .font(Font.custom("DMSans-Medium", size: 14))
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
                        
                        // MARK: Transfer Amount Section
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
                                
                                TextField("0.00", text: $transferAmount)
                                    .modifyInputCurrency(value: $transferAmount)
                                    .font(Font.custom("DMSans-Medium", size: 24))
                                    .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                                    .padding(.bottom, 16)
                                    .padding(.leading, 12)
                                    .keyboardType(.numberPad)
                                    .focused($transferAmountKeyboardFocused)
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            transferAmountKeyboardFocused = true
                                        }
                                    }
                                    .disabled({
                                        if isLoading {
                                            return true
                                        }
                                        else {
                                            return false
                                        }
                                    }())
                            }
                        }
                        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                        .padding(.top, 28)
                        .padding(.bottom, 81)
                        .animation(.easeInOut, value: foundUser)
                        
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
                        
                        // MARK: Continue Transfer Section
                        Button {
                            transferAmountKeyboardFocused = false
                            invalidMessages = ""
                            
                            if transferVM.checkBalance(balanceString: userDataVM.userBalance, amountString: transferAmount) {
                                isPresentingConfirmPayment = true
                                
                            } else {
                                invalidMessages = "Insufficient balance."
                            }
                            
                            
                        } label: {
                            if transferAmount == "" || transferAmount == "0.00" {
                                Image("continueButtonInactive")
                                    .cornerRadius(8)
                            }
                            else {
                                Image("continueButton")
                                    .cornerRadius(8)
                            }
                        }
                        .disabled({
                            if isLoading || transferAmount == "" || transferAmount == "0.00" {
                                return true
                            }
                            else {
                                return false
                            }
                        }())
                        Spacer()
                    }
                }
                // MARK: Search Payee Section
                else {
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 11) {
                            HStack {
                                Text("Enter the user ID")
                                    .font(Font.custom("DMSans-Medium", size: 14))
                                    .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                                    .padding(.top, 15)
                                    .padding(.leading, 30)
                                
                                Button {
                                    isPresentingIDInformation = !isPresentingIDInformation
                                } label: {
                                    if isPresentingIDInformation {
                                        Image(systemName: "questionmark.circle.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                                            .padding(.top, 15)
                                    }
                                    else {
                                        Image(systemName: "questionmark.circle")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                                            .padding(.top, 15)
                                    }
                                }
                            }
                            
                            TextField("", text: $transferID)
                                .limitInputLength(value: $transferID, length: 16+3)
                                .font(Font.custom("DMSans-Medium", size: 24))
                                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                                .padding(.bottom, 16)
                                .padding(.leading, 30)
                                .keyboardType(.numberPad)
                                .focused($userIDKeyboardFocused)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        userIDKeyboardFocused = true
                                    }
                                }
                        }
                        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                        .disabled(isLoading)
                        
                        if isPresentingIDInformation {
                            Text("User ID should contain 16 digits")
                                .font(Font.custom("DMSans-Regular", size: 12))
                                .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                                .padding(.leading, 30)
                                .padding(.top, 5)
                        }
                    }
                    .padding(.top, 28)
                    .padding(.bottom, 43)
                    .animation(.easeInOut, value: foundUser)
                    
                    if invalidTransferID {
                        Text("Invalid ID. Please enter a correct ID with 16 digits")
                            .font(Font.custom("DMSans-Medium", size: 10))
                            .foregroundColor(.red)
                    }
                    
                    Button {
                        let countTransferID = transferID.filter {!$0.isWhitespace}
                        invalidTransferID = false
                        
                        if countTransferID.count < 16 {
                            invalidTransferID = true
                        }
                        else {
                            userIDKeyboardFocused = false
                            isLoading = true
                            
                            transferVM.checkPayeeID(accessToken: userDataVM.getAccessToken()!, payeeID: countTransferID) { success in
                                
                                if success {
                                    foundUser = true
                                }
                                else {
                                    invalidTransferID = true
                                }
                                isLoading = false
                            }
                        }
                        
                    } label: {
                        let countTransferID = transferID.filter {!$0.isWhitespace}
                        if countTransferID.count < 16 {
                            Image("nextButtonInactive")
                                .cornerRadius(8)
                        }
                        else {
                            Image("nextButton")
                                .cornerRadius(8)
                        }
                    }
                    .disabled({
                        let countTransferID = transferID.filter {!$0.isWhitespace}
                        if countTransferID.count < 16 || isLoading {
                            return true
                        }
                        else {
                            return false
                        }
                    }())
                }
                Spacer()
            }
            .background(Color(red: 246/255, green: 246/255, blue: 246/255))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Transfer to")
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
                userIDKeyboardFocused = false
                transferAmountKeyboardFocused = false
            }
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    dismiss()
                }
            }))
            
            ConfirmPaymentView(isPresenting: $isPresentingConfirmPayment, title: "details", subtitle: "Transfer", amount: String(transferAmount), account: "Balance", buttonTitle: "Transfer", isConfirm: $isConfirm)
            
            if foundUser {
                ConfirmPaymentPinView(accessToken: userDataVM.getAccessToken()!, isPresenting: $isConfirmingPin, isCancel: $isCancel, isFinish: $isPresentingSuccessPayment, fid: fid, serverAddress: "/checkTransferTo")
            }
            
            LoadingView(message: "Loading", isLoading: $isLoading)
        }
        .sheet(isPresented: $isPresentingSuccessPayment) {
            SuccessPaymentView(subtitle: "Successfully transferred", amount: String(transferAmount), message: " To \(transferVM.payeeName)", isPresenting: $isPresentingSuccessPayment, finishedProcess: $finishedTransfer)
        }
        .onChange(of: finishedTransfer) { newValue in
            dismiss()
        }
        .onChange(of: transferAmountKeyboardFocused) { newValue in
            if transferAmountKeyboardFocused == true && transferAmount == "" {
                transferAmount = "0.00"
            }
        }
        .onChange(of: isConfirm) { newValue in
          
            if isConfirm {
                isLoading = true
                
                transferVM.transfer(accessToken: userDataVM.getAccessToken()!, payeeID: transferID.filter {!$0.isWhitespace}, amount: transferAmount) { result in
                    
                    switch result {
                    case .success(let fid):
                        self.fid = fid
                        isConfirmingPin = true
                        
                    case .failure(let error):
                        invalidMessages = error.localizedDescription
                    }
                    isLoading = false
                    isConfirm = false
                }
            }
        }
        .onChange(of: isCancel) { newValue in
            if isCancel {
                fid = ""
                invalidMessages = "Please try again."
                isCancel = false
            }
        }
    }
}


struct JacarandaTransferView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                JacarandaTransferView()
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "16283589494989", isPresentingIDInformation: true)
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "1628358949498689")
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "1628358949498689", invalidTransferID: true)
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "1234 4567 8900 5858", foundUser: true)
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "1234 4567 8900 5858", foundUser: true, transferAmount: "180.00")
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "1234 4567 8900 5858", foundUser: true, transferAmount: "180.00", isPresentingConfirmPayment: true)
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "1234 4567 8900 5858", foundUser: true, transferAmount: "180,00", isLoading: true)
            }
        }
    }
}
