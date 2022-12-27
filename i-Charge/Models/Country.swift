//
//  Country.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import Foundation


struct Country: Codable{
    let title: String
    
    enum CodingKeys: String, CodingKey{
        case title = "Title"
    }
}
