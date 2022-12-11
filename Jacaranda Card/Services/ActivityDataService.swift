//
//  ActivityDataService.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import Foundation


struct ActivityRequestBody: Codable {
    let time: String
}


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
    
    
    static func getOnlineData(accessToken: String, time: String, completion: @escaping (Result<String, GeneralError>) -> Void) {
        
        // MARK: Server URL: https://xp.lycyy.cc
        guard let url = URL(string: "https://xp.lycyy.cc/bill") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(accessToken, forHTTPHeaderField: "token")
        
        let body = ActivityRequestBody(time: time)
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let activityResponse = try? JSONDecoder().decode(GeneralResponseBody.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Fail to decode from data")))
                return
            }
    
            guard activityResponse.code == "200" else {
                completion(.failure(.custom(errorMessage: "Fail to get activities data")))
                return
            }
            
            guard let response = activityResponse.data else {
                completion(.failure(.custom(errorMessage: "Fail to access activities data")))
                return
            }
            
            completion(.success(response))
            
        }.resume()
    }
}
