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
    
    @State var isPresentingConfirmPayment = false
    @State var isPresentingSuccessPayment = false
    @State var isLoading = false
    @State var finishedTransfer = false
    @State var invalidTransferID = false
    
    @FocusState private var userIDKeyboardFocused: Bool
    @FocusState private var transferAmountKeyboardFocused: Bool
    
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
                                        .fill(Color(red: 215/255, green: 199/255, blue: 228/255))
                                        .frame(width: 63, height: 63)
                                }
                            
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Irene qq")
                                        .font(.system(size: 18))
                                        .fontWeight(.bold)
                                    Text(transferID.applyPattern())
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
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
                                .keyboardType(.decimalPad)
                                .focused($transferAmountKeyboardFocused)
                                .disabled({
                                    if isLoading {
                                        return true
                                    }
                                    else {
                                        return false
                                    }
                                }())
                        }
                        .background(Color(red: 252/255, green: 252/255, blue: 252/255))
                        .padding(.top, 28)
                        .padding(.bottom, 81)
                        .animation(.easeInOut, value: foundUser)
                        
                        // MARK: Continue Transfer Section
                        Button {
                            transferAmountKeyboardFocused = false
                            isPresentingConfirmPayment = true
                        } label: {
                            Image("continueButton")
                                .cornerRadius(8)
                        }
                        .disabled({
                            if isLoading {
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
                    VStack(alignment: .leading, spacing: 11) {
                        Text("Enter the user ID")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 172/255, green: 172/255, blue: 176/255))
                            .padding(.top, 15)
                            .padding(.leading, 30)
                        
                        TextField("", text: $transferID)
                            .limitInputLength(value: $transferID, length: 16+3)
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
                    
                    if invalidTransferID {
                        Text("Invalid ID. Please enter a correct ID with 16 digits")
                            .font(.system(size: 10))
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                    }
                    
                    Button {
                        let countTransferID = transferID.filter {!$0.isWhitespace}
                        if countTransferID.count < 16 {
                            invalidTransferID = true
                        }
                        else {
                            userIDKeyboardFocused = false
                            foundUser = true
                        }
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
                transferAmountKeyboardFocused = false
            }
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    self.mode.wrappedValue.dismiss()
                }
            }))
            
            ConfirmPaymentView(isPresenting: $isPresentingConfirmPayment, title: "details", subtitle: "Transfer", amount: transferAmount, account: "Balance", buttonTitle: "Transfer", isLoading: $isLoading)
            
            LoadingView(message: "Loading", isLoading: $isLoading, isFinished: $isPresentingSuccessPayment)
        }
        .sheet(isPresented: $isPresentingSuccessPayment) {
            SuccessPaymentView(subtitle: "Sucessfully transferred", amount: transferAmount, message: " To Irene qq", isPresenting: $isPresentingSuccessPayment, finishedProcess: $finishedTransfer)
        }
        .onChange(of: finishedTransfer) { newValue in
            self.mode.wrappedValue.dismiss()
        }
    }
}


struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = value.filter {!$0.isWhitespace}
                value = String($0.prefix(length))
                value = value.applyPattern()
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}


struct JacarandaTransferView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                JacarandaTransferView()
            }
            
            NavigationView {
                JacarandaTransferView(invalidTransferID: true)
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "1234 4567 8900 5858", foundUser: true)
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "1234 4567 8900 5858", foundUser: true, transferAmount: "180.00", isPresentingConfirmPayment: true)
            }
            
            NavigationView {
                JacarandaTransferView(transferID: "1234 4567 8900 5858", foundUser: true, transferAmount: "180.00", isLoading: true)
            }
        }
    }
}
