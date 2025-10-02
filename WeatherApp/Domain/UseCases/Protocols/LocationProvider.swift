//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol LocationProvider {
    func getCurrentLocation() throws -> Coordinates
}
