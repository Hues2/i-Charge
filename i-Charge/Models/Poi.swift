//
//  Poi.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import Foundation

struct Poi: Codable, Identifiable{
    let id: Int
    let addressInfo: AddressInfo
    
    
    enum CodingKeys: String, CodingKey{
        case id = "ID"
        case addressInfo = "AddressInfo"
    }
    
}
