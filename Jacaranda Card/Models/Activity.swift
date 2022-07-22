//
//  Activity.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import Foundation

class Activity: Identifiable, Decodable {
    
    var id: UUID?
    var name: String
    var date: String
    var amount: Float
    var amountString: String {
        if amount >= 0 {
            return String(format: "+ $ %.2f", amount)
        }
        else {
            return String(format: "- $ %.2f", abs(amount))
        }
    }
}
