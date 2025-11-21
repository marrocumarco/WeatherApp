//
//  WeatherUseCaseImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct FetchWeatherUseCaseImpl: FetchWeatherUseCase {
    
    let weatherRepository: WeatherRepository
    let geocoder: Geocoder
    
    func fetchWeatherFor(_ location: Coordinates) async throws -> Weather {
        return try await weatherRepository.fetchWeatherBy(location)
    }

    func fetchWeatherFor(_ cityName: String) async throws -> Weather {
        return try await weatherRepository.fetchWeatherBy(cityName)
    }
}
