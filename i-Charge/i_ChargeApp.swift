//
//  i_ChargeApp.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import SwiftUI

@main
struct i_ChargeApp: App {
    
    @StateObject private var mapDataService = MapDataService()
    
    var body: some Scene {
        WindowGroup {
            AppView(mapDataService: mapDataService)
        }
    }
}
