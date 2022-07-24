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
    var dateString: String
    var date: Date {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd MMM yy"

        // Convert String to Date
        if let dateUnwrap = dateFormatter.date(from: dateString) {
            return dateUnwrap
        }
        return Date.now
    }
    var imageName: String
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
