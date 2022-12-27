//
//  AppView.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import SwiftUI

struct AppView: View {
    
    var mapDataService: MapDataService
    
    init(mapDataService: MapDataService){
        self.mapDataService = mapDataService
    }
    
    var body: some View {
        MapView(mapDataService: mapDataService)
    }
}
