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
        
        ActivityDataService.getOnlineData(accessToken: accessToken, time: "2022-12-11") { result in
            
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
}

// time
