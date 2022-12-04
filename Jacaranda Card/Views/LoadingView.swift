//
//  LoadingView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 7/8/2022.
//

import SwiftUI

struct LoadingView: View {
    
    var message: String
    @Binding var isLoading: Bool
    @Binding var isFinished: Bool
    
    var body: some View {
        if isLoading {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                        .padding(.top, 40)
                        
                        Spacer()
                        
                        Text(message)
                            .font(Font.custom("DMSans-Medium", size: 20))
                            .foregroundColor(.white)
                            .padding(.bottom, 19)
                    }
                    .frame(width: 154, height: 140)
                    .background(Color(red: 30/255, green: 30/255, blue: 30/255, opacity: 0.77))
                    .cornerRadius(12)
                    Spacer()
                }
                Spacer()
            }
            .onAppear(
                perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        isLoading = false
                        isFinished = true
                    }
                }
            )
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(message: "Loading", isLoading: .constant(true), isFinished: .constant(false))
    }
}
