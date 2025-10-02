//
//  ApiClient.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol ApiClient {
    func fetchWeatherBy(_ coordinates: Coordinates) async throws -> Weather
    
    func fetchWeatherBy(_ cityName: String) async throws -> Weather
}
