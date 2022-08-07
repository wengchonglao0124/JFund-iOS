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
                ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
                .padding(.top, 40)
                
                Spacer()
                
                Text(message)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.bottom, 19)
            }
            .frame(width: 154, height: 140)
            .background(Color(red: 30/255, green: 30/255, blue: 30/255, opacity: 0.77))
            .cornerRadius(12)
            .onAppear(
                perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
