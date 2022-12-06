//
//  SuccessContentView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 6/12/2022.
//

import SwiftUI

struct SuccessContentView: View {
    
    var message: String
    var subtitle: String
    
    @Binding var isPresenting: Bool
    @Binding var finishedProcess: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Image("successIcon")
                .padding(.bottom, 75)
                .padding(.top, 107)
            
            Text(message)
                .font(Font.custom("DMSans-Medium", size: 24))
                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 30/255))
                .frame(width: 260)
                .multilineTextAlignment(.center)
            
            if !subtitle.isEmpty {
                Text(subtitle)
                    .font(Font.custom("DMSans-Medium", size: 16))
                    .foregroundColor(Color(red: 151/255, green: 151/255, blue: 151/255))
                    .frame(width: 277)
                    .multilineTextAlignment(.center)
                    .padding(.top, 29)
                    .padding(.bottom, 75)
            }
            
            Button {
                print("Done")
                isPresenting = false
                finishedProcess = true
            } label: {
                Image("doneIcon")
                    .cornerRadius(8)
            }
            .padding(.top, 75)
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

struct SuccessContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            SuccessContentView(message: "You have created your account sucessfully!", subtitle: "", isPresenting: .constant(true), finishedProcess: .constant(false))
            
            SuccessContentView(message: "Content submitted", subtitle: "Your content will be reviewed by the admin which takes up to 24 hours", isPresenting: .constant(true), finishedProcess: .constant(false))
        }
    }
}
