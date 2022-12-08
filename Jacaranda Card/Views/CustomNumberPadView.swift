//
//  CustomNumberPadView.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 8/12/2022.
//

import SwiftUI

struct CustomNumberPadView: View {
    
    @Binding var password: String
    
    var body: some View {
       
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
            
            ForEach(1...9, id: \.self) { value in
                
                PasswordButton(value: "\(value)", password: $password)
            }
            
            PasswordButton(value: "", password: $password)
            
            PasswordButton(value: "0", password: $password)
            
            PasswordButton(value: "delete.fill", password: $password)
        }
    }
}


struct PasswordButton: View {
    
    var value: String
    @Binding var password: String
    
    var body: some View {
        
        Button {
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.impactOccurred()
            setPassword()
            
        } label: {
            VStack {
                if value.count > 1 {
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                }
                else {
                    Text(value)
                        .font(.title)
                        .foregroundColor(Color(red: 30/255, green: 30/255, blue: 32/255))
                }
            }
            .padding()
            .frame(maxWidth: 135, maxHeight: 55)
            .background(value.count != 0 ? Color(red: 151/255, green: 151/255, blue: 151/255, opacity: 0.05) : .clear)
            .cornerRadius(10)
        }
    }
    
    
    func setPassword() {
        
        if value.count > 1 {
            if password.count > 0 {
                password.removeLast()
            }
            
        }
        else {
            if value.count != 0 {
                if password.count < 6 {
                    password.append(value)
                }
            }
        }
    }
}


struct CustomNumberPadView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CustomNumberPadView(password: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
