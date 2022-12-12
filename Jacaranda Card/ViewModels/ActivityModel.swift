//
//  ActivityModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import Foundation

class ActivityModel: ObservableObject {
    
    @Published var activies = [Activity]()
    
    func updateActivityForTestingOnly() {
        self.activies = ActivityDataService.getLocalData()
    }
    
    
    func updateActivityRecords(accessToken: String) {
        
        let dateTime = DateService.getDateString(format: "yyyy-MM-dd HH:mm:ss", date: Date.now)
        
        ActivityDataService.getOnlineData(accessToken: accessToken, time: dateTime) { result in
            
            switch result {
            case .success(let data):
                
                do {
                    let jsonData = data.data(using: .utf8)
                    
                    // Create a data obect
                    let decoder = JSONDecoder()
                    
                    do {
                        // Decode the data with a JSON decoder
                        let activityData = try decoder.decode([Activity].self, from: jsonData!)
                        
                        // Add a unique ID
                        for activity in activityData {
                            activity.id = UUID()
                        }
                        
                        DispatchQueue.main.sync {
                            
                            if let lastActivity = activityData.sorted(by: { $0.date.compare($1.date) == .orderedDescending }).last {
                                
                                UserDefaults.standard.set(lastActivity.dateString, forKey: "lastActivityDate")
                                UserDefaults.standard.set(lastActivity.receipt, forKey: "lastActivityReceipt")
                            }
                            // update the activities
                            self.activies = activityData
                        }
                    }
                    catch {
                        // error with parsing json
                        print(error)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func updateActivityMoreRecords(accessToken: String) {
        
        guard let dateTime = UserDefaults.standard.string(forKey: "lastActivityDate") else {
            return
        }
        
        guard let lastReceipt = UserDefaults.standard.string(forKey: "lastActivityReceipt") else {
            return
        }
        
        ActivityDataService.getOnlineData(accessToken: accessToken, time: dateTime) { result in
            
            switch result {
            case .success(let data):
                
                do {
                    let jsonData = data.data(using: .utf8)
                    
                    // Create a data obect
                    let decoder = JSONDecoder()
                    
                    do {
                        // Decode the data with a JSON decoder
                        let activityData = try decoder.decode([Activity].self, from: jsonData!)
                        
                        // Add a unique ID
                        for activity in activityData {
                            activity.id = UUID()
                        }
                        
                        DispatchQueue.main.sync {
                            
                            if let lastActivity = activityData.sorted(by: { $0.date.compare($1.date) == .orderedDescending }).last {
                                
                                UserDefaults.standard.set(lastActivity.dateString, forKey: "lastActivityDate")
                                UserDefaults.standard.set(lastActivity.receipt, forKey: "lastActivityReceipt")
                            }
                            // update the activities
                            self.activies += activityData.filter {$0.receipt != lastReceipt}
                        }
                    }
                    catch {
                        // error with parsing json
                        print(error)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
