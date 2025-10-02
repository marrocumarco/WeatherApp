//
//  WeatherUseCase.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol WeatherUseCase {
    func fetchWeatherForCurrentLocation() async throws -> Weather
    func fetchWeatherFor(_ cityName: String) async throws -> Weather
    func fetchImageFor(_ weather: Weather) async throws -> Data
}
