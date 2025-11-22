//
//  Persistence.swift
//  WeatherApp
//
//  Created by maomar on 22/11/25.
//

import Foundation

struct LocalDataSourceImpl: LocalDataSource {
    
    private let locationsKey = "locationsKey"
    
    func save(locations: [String]) throws {
        UserDefaults.standard.setValue(locations, forKey: locationsKey)
    }
    
    func getLocations() -> [String] {
        UserDefaults.standard.value(forKey: locationsKey) as? [String] ?? []
    }
}
