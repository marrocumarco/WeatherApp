//
//  LocationsRepositoryImpl.swift
//  WeatherApp
//
//  Created by maomar on 22/11/25.
//

import Foundation

struct LocationsRepositoryImpl: LocationsRepository {
    
    let localDataSource: LocalDataSource
    
    func save(locations: [String]) throws {
        try localDataSource.save(locations: locations)
    }
    
    func getLocations() throws -> [String] {
        localDataSource.getLocations()
    }
}
