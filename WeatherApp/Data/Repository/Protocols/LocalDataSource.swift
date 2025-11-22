//
//  LocalDataSource.swift
//  WeatherApp
//
//  Created by maomar on 22/11/25.
//

import Foundation

protocol LocalDataSource {
    func save(locations: [String]) throws
    func getLocations() -> [String]
}
