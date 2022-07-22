//
//  ActivityDataService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import Foundation

class ActivityDataService {
    
    static func getLocalData() -> [Activity] {
        
        // Parse local json file
        let pathString = Bundle.main.path(forResource: "activities", ofType: "json")
        
        // Check if pathString is not nil, otherwise...
        guard pathString != nil else {
            return [Activity]()
        }
        
        // Get a url path to the json file
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // Create a url object
            let data = try Data(contentsOf: url)
            
            // Create a data obect
            let decoder = JSONDecoder()
            
            do {
                // Decode the data with a JSON decoder
                let activityData = try decoder.decode([Activity].self, from: data)
                
                // Add a unique ID
                for activity in activityData {
                    activity.id = UUID()
                }
                
                // Return the recipes
                return activityData
            }
            catch {
                // error with parsing json
                print(error)
            }
        }
        catch {
            // error with getting data
            print(error)
        }
        
        // if getting some errors above
        return [Activity]()
    }
}
