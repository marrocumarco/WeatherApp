//
//  SaveLocationsUseCaseImpl.swift
//  WeatherApp
//
//  Created by maomar on 22/11/25.
//

import Foundation

struct SaveLocationsUseCaseImpl: SaveLocationsUseCase {
    
    let locationsRepository: LocationsRepository
    
    func save(locations: [String]) throws {
        try locationsRepository.save(locations: locations)
    }
}
