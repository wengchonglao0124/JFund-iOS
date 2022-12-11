//
//  Activity.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import Foundation

class Activity: Identifiable, Decodable {
    
    var id: UUID?
    var receipt: String
    var type: String
    
    // ID
    var receiveUser: String
    var receiveUsername: String
    // Image name or Color code
    var receiveColor: String
   
    // ID
    var payUser: String
    var payUsername: String
    // Image name or Color code
    var payColor: String
    
    var username: String {
        if type == "receive" {
            return payUsername
        }
        else if type == "top-up" {
            return "Top up to Balance"
        }
        else {
            // type = "pay"
            return receiveUsername
        }
    }
    
    var dateString: String
    var date: Date {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        // Convert String to Date
        if let dateUnwrap = dateFormatter.date(from: dateString) {
            return dateUnwrap
        }
        return Date.now
    }
    
    var imageName: String {
        
        if type == "top-up" {
            return "topUpIcon"
        }
        else if type == "receive" {
            return payColor
        }
        else {
            // type = "pay"
            return receiveColor
        }
    }
    
    var amount: String
    var amountString: String {
        
        let amountFloat = Float(amount)!
        
        if type == "receive" || type == "top-up" {
            return String(format: "+ $ %.2f", amountFloat)
        }
        else {
            return String(format: "- $ %.2f", abs(amountFloat))
        }
    }
    
    var isHavingBonus: Bool {
        
        if type == "top-up" {
            let amountFloat = Float(amount)!
            if amountFloat >= 100 {
                return true
            }
        }
        
        return false
    }
    
    var bonusLength: Int {
        
        if type == "top-up" {
            let amountFloat = Float(amount)!
            if amountFloat < 1000 {
                return 2
            }
            else {
                return 3
            }
        }
        return 0
    }
    
    var extraAmount: String {
        
        if type == "top-up" {
            let amountFloat = Float(amount)!
            let amountInt: Int = Int(amountFloat)
            
            let bonusStep: Int = 100
            let bonus = 10*(amountInt/bonusStep)
            
            return "+ $ \(bonus)"
            
        }
        else {
            return ""
        }
    }
}
