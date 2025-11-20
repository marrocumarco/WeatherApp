//
//  Geocoder.swift
//  WeatherApp
//
//  Created by maomar on 19/11/25.
//

import Foundation

protocol Geocoder {
    func getCoordinatesFrom(_ address: String) async throws -> Coordinates
}
