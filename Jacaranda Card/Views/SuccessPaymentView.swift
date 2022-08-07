//
//  SuccessPaymentView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 7/8/2022.
//

import SwiftUI

struct SuccessPaymentView: View {
    
    var subtitle: String
    var amount: String
    var message: String
    
    @Binding var isPresenting: Bool
    @Binding var finishedProcess: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Image("successIcon")
                .padding(.bottom, 45)
                .padding(.top, 107)
                
            Text(subtitle)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color(red: 137/255, green: 138/255, blue: 141/255))
                .padding(.bottom, 18)
            
            Text("$ \(amount)")
                .font(.system(size: 32))
                .fontWeight(.medium)
                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                .padding(.bottom, 17)
            
            Text(message)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 115)
            
            Button {
                print("Done")
                isPresenting = false
                finishedProcess = true
            } label: {
                Image("doneIcon")
                    .cornerRadius(8)
            }
            Spacer()
        }
        .onAppear(
            perform: {
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                impactHeavy.impactOccurred()
            }
        )
        .onDisappear(
            perform: {
                finishedProcess = true
            }
        )
    }
}

struct SuccessPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SuccessPaymentView(subtitle: "Sucessfully transferred", amount: "250.00", message: " To Irene qq", isPresenting: .constant(true), finishedProcess: .constant(false))
            
            SuccessPaymentView(subtitle: "Top up sucessfully", amount: "180.00", message: "", isPresenting: .constant(true), finishedProcess: .constant(false))
        }
    }
}
