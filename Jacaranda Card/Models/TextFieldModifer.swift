//
//  TextFieldModifer.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 8/8/2022.
//

import SwiftUI


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


struct TextFieldCurrencyModifer: ViewModifier {
    @Binding var value: String

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(value.count))
                let dotIndex = value.firstIndex(of: ".")
                if let index = dotIndex {
                    value.remove(at: index)
                }
                if value.count > 0 {
                    if value.first == "0" {
                        value.remove(at: value.startIndex)
                    }
                    if value.first == "0" {
                        value.remove(at: value.startIndex)
                    }
                }
                if value.count > 0 && value.count < 3 {
                    if value.count == 1 {
                        value.insert("0", at: value.startIndex)
                    }
                    value.insert("0", at: value.startIndex)
                }
                value = String(value.reversed())
                value = value.applyCurrencyPattern()
                value = String(value.reversed())
            }
    }
}


extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
    
    func modifyInputCurrency(value: Binding<String>) -> some View {
        self.modifier(TextFieldCurrencyModifer(value: value))
    }
}
