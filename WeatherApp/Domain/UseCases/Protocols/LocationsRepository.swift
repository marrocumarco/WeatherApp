//
//  LocationsRepository.swift
//  WeatherApp
//
//  Created by maomar on 22/11/25.
//

import Foundation

protocol LocationsRepository {
    func save(locations: [String]) throws
    func getLocations() throws -> [String]
}
