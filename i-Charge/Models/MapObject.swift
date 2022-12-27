//
//  MapObject.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import Foundation
import MapKit

struct MapObject: Identifiable{
    let id: UUID = UUID()
    let poi: Poi
    let coordinates: CLLocationCoordinate2D
}
