//
//  SaveLocationsUseCase.swift
//  WeatherApp
//
//  Created by maomar on 22/11/25.
//

import Foundation

protocol SaveLocationsUseCase {
    func save(locations: [String]) throws
}
