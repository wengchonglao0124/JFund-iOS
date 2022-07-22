//
//  ActivityModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 22/7/2022.
//

import Foundation

class ActivityModel: ObservableObject {
    
    @Published var activies = [Activity]()
    
    init() {
        self.activies = ActivityDataService.getLocalData()
    }
}


