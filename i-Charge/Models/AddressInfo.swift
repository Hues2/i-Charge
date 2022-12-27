//
//  AddressInfo.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import Foundation


struct AddressInfo: Codable{
    let id: Int
    let title: String
    let addressLine1: String?
    let addressLine2: String?
    let town: String?
    let stateOrProvince: String?
    let postcode: String?
    let country: Country
    let latitude: Double?
    let longitude: Double?
    
    
    enum CodingKeys: String, CodingKey{
        case id = "ID"
        case title = "Title"
        case addressLine1 = "AddressLine1"
        case addressLine2 = "AddressLine2"
        case town = "Town"
        case stateOrProvince = "StateOrProvince"
        case postcode = "Postcode"
        case country = "Country"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
    
}
