//
//  BusinessPartnerModel.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 23/7/2022.
//

import Foundation

class BusinessPartnerModel: ObservableObject {
    
    @Published var restaurants = [BusinessPartner]()
    @Published var beauties = [BusinessPartner]()
    @Published var tourisms = [BusinessPartner]()
    
    init() {
        self.restaurants = RestaurantDataService.getLocalData()
        self.beauties = BeautyDataService.getLocalData()
        self.tourisms = TourismDataService.getLocalData()
    }
}
