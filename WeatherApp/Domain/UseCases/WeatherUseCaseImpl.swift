//
//  WeatherUseCaseImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct WeatherUseCaseImpl: WeatherUseCase {
    let locationProvider: LocationProvider
    let weatherRepository: WeatherRepository
    
    func fetchWeatherForCurrentLocation() async throws -> Weather {
        let coordinates = try locationProvider.getCurrentLocation()
        return try await weatherRepository.fetchWeatherBy(coordinates)
    }

    func fetchWeatherFor(_ cityName: String) async throws -> Weather {
        return try await weatherRepository.fetchWeatherBy(cityName)
    }
    
    func fetchImageFor(_ weather: Weather) async throws -> Data {
        try await weatherRepository.fetchImageWith(weather.iconId)
    }
}
