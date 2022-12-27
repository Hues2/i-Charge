//
//  MapDataService.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import Foundation
import Combine


class MapDataService: ObservableObject{

    var apiDataPublisher = PassthroughSubject<Result<[Poi], CustomError>, Never>()
    
    let apiKey = ""
    var poisApiUrl: String {
        "https://api.openchargemap.io/v3/poi?key=\(apiKey)"
    }
    
    
    private var cancellables = Set<AnyCancellable>()

    
    func fetchAllPOIs(){
        guard let url = URL(string: poisApiUrl) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: [Poi].self, decoder: JSONDecoder())
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion{
                case .failure(let error):
                    self.apiDataPublisher.send(.failure(.completionFailed(errorMessage: error.localizedDescription)))
                    
                case .finished:
                    break
                }
            } receiveValue: { [weak self] returnedPoi in
                self?.apiDataPublisher.send(.success(returnedPoi))
            }
            .store(in: &cancellables)

    }
    
    
}
