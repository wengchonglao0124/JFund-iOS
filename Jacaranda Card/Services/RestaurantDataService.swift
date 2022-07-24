//
//  RestaurantDataService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 23/7/2022.
//

import Foundation

class RestaurantDataService {
    
    static func getLocalData() -> [BusinessPartner] {
        
        // Parse local json file
        let pathString = Bundle.main.path(forResource: "restaurants", ofType: "json")
        
        // Check if pathString is not nil, otherwise...
        guard pathString != nil else {
            return [BusinessPartner]()
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
                let businessPartnerData = try decoder.decode([BusinessPartner].self, from: data)
                
                // Add a unique ID
                for businessPartner in businessPartnerData {
                    businessPartner.id = UUID()
                }
                
                // Return the recipes
                return businessPartnerData
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
        return [BusinessPartner]()
    }
}
