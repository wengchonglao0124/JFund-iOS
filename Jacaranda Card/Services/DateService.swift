//
//  DateService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 25/7/2022.
//

import Foundation

class DateService {
    
    var currentDate = ""
    
    static func getDateString(format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func getDateStringLocal(format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func getActivityCollectionByDate(activityList: [Activity], date: String, format: String) -> [Activity] {
        var resultList = [Activity]()
        
        if currentDate != date {
            currentDate = date
            
            for activity in activityList {
                if currentDate == getDateStringLocal(format: format, date: activity.date) {
                    resultList.append(activity)
                }
            }
        }
        return resultList
    }
}
