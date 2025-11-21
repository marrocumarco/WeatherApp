//
//  FetchWeatherUseCase.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol FetchWeatherUseCase {
    func fetchWeatherFor(_ location: Coordinates) async throws -> Weather
    func fetchWeatherFor(_ cityName: String) async throws -> Weather
}
