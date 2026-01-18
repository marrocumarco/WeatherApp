//
//  Persistence.swift
//  WeatherApp
//
//  Created by maomar on 22/11/25.
//

import Foundation

struct LocalDataSourceImpl: LocalDataSource {

    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    private let locationsKey = "locationsKey"
    private let userDefaults: UserDefaults

    func save(locations: [String]) throws {
        userDefaults.setValue(locations, forKey: locationsKey)
    }
    
    func getLocations() -> [String] {
        userDefaults.value(forKey: locationsKey) as? [String] ?? []
    }
}
