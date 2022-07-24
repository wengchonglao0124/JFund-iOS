//
//  BusinessPartner.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 23/7/2022.
//

import Foundation

class BusinessPartner: Identifiable, Decodable {
    
    var id: UUID?
    var name: String
    var address: String
    var distance: String
    var image: String
}
