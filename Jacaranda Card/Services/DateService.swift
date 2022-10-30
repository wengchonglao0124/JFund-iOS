//
//  DateService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 25/7/2022.
//

import Foundation

class DateService {
    
    static func getDateString(format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    static func getActivityCollectionByDate(activityList: [Activity]) -> [String:[Activity]] {
        var results = [String:[Activity]]()
        
        for activity in activityList {
            let date = DateService.getDateString(format: "MMM yyyy", date: activity.date)
            
            if results.keys.contains(date) {
                results[date]!.append(activity)
            }
            else {
                results[date] = [activity]
            }
        }
        return results
    }
}
