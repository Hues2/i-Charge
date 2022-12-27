//
//  MapViewModel.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import Foundation
import MapKit
import Combine
import SwiftUI


final class MapViewModel: ObservableObject{
        
    /// This is what needs to change for the map do move and display it on screen
    @Published var mapRegion = MKCoordinateRegion()
    @Published var mapObjects = [MapObject]()
    @Published var selectedMapObject: MapObject? = nil
    @Published var showList: Bool = false
    
    
    let delta = 1.0
    
    
    private var mapDataService: MapDataService
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(mapDataService: MapDataService) {
        self.mapDataService = mapDataService
        self.addSubscribers()
        self.mapDataService.fetchAllPOIs()
    }
    
    
    private func addSubscribers(){
        
        self.mapDataService.apiDataPublisher
            .sink { [weak self] returnedResult in
                guard let self else { return }
                switch returnedResult{
                case .failure(let error):
                    print("\n Map Data Service returned an error: \(error.message) \n")
                case.success(let pois):
                    /// Populate the map objects with the API data
                    let listOfMapObjects: [MapObject?] = pois.map({
                        guard let latitude = $0.addressInfo.latitude, let longitude = $0.addressInfo.longitude else { return nil}
                        
                        return MapObject(poi: $0, coordinates: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                    })
                    
                    /// Map Objects now only has objects with valid coordinates
                    self.mapObjects = listOfMapObjects.compactMap({$0})
                    
                    /// This sets the selected location as the first map object
                    guard let firstMapObject = self.mapObjects.first else { return }
                    self.selectedMapObject = firstMapObject
                    
                }
            }
            .store(in: &cancellables)

        
        /// When the selected location changes, set thew map region to that location
        /// This selected location is set on app launch, with the first map object available
        /// Users can then tap on map markers to change the selected location
        self.$selectedMapObject
            .dropFirst()
            .sink { [weak self] returnedMapObject in
                guard let self else { return }
                guard let returnedMapObject else { return }
                DispatchQueue.main.async {
                    withAnimation {
                        self.showList = false
                        self.mapRegion = MKCoordinateRegion(center: returnedMapObject.coordinates, span: MKCoordinateSpan(latitudeDelta: self.delta, longitudeDelta: self.delta))
                    }
                    
                }
                
            }
            .store(in: &cancellables)
        
        
    }
    
}
