//
//  WeatherUseCase.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol WeatherUseCase {
    func fetchWeatherFor(_ location: Coordinates) async throws -> Weather
    func fetchTodayForecastFor(_ location: Coordinates) async throws -> [Forecast]
    func fetchWeatherFor(_ cityName: String) async throws -> Weather
    func fetchImageFor(_ weather: Weather) async throws -> Data
}
