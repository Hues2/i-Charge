//
//  MapView.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var vm: MapViewModel
    
    init(mapDataService: MapDataService){
        self._vm = StateObject(wrappedValue: MapViewModel( mapDataService: mapDataService))
    }
    
    var body: some View {
        ZStack{
            
            //MARK: - Map
            map
            
            //MARK: - Header
            header
 
        }
        
    }
}

extension MapView{
    
    private var headerTitle: some View{
        HStack{
            Text("\(vm.selectedMapObject?.poi.addressInfo.title ?? "")")
                .font(.title3)
                .fontWeight(.bold)
            
            Spacer()
            
            Image(systemName: "arrow.right")
                .font(.title3)
                .rotationEffect(Angle(degrees: vm.showList ? 90 : 0))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
            withAnimation {
                vm.showList.toggle()
            }
        }
    }
    
    private var header: some View{
        VStack{
            
            VStack(spacing: 0){
                
                //MARK: - Header Title
                headerTitle
                
                    
                if vm.showList{
                    List{
                        ForEach(vm.mapObjects){ mapObject in
                            HStack{
                                Text("\(mapObject.poi.addressInfo.title)")
                                
                                Spacer()
                                
                                if let selectedMapObject = vm.selectedMapObject{
                                    if selectedMapObject.poi.id == mapObject.poi.id{
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            .listRowBackground(Color.clear)
                            .contentShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                withAnimation {
                                    vm.selectedMapObject = mapObject
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
                
            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
            
            Spacer()
        }
    }
    
    private var map: some View{
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.mapObjects) { mapObject in
            MapMarker(coordinate: mapObject.coordinates)
        }
        .ignoresSafeArea()
    }
}
