//
//  WeatherUseCaseImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct WeatherUseCaseImpl: WeatherUseCase {

    let weatherRepository: WeatherRepository
    let numberOfForecasts = 8
    
    func fetchWeatherFor(_ location: Coordinates) async throws -> Weather {
        return try await weatherRepository.fetchWeatherBy(location)
    }

    func fetchWeatherFor(_ cityName: String) async throws -> Weather {
        return try await weatherRepository.fetchWeatherBy(cityName)
    }
    
    func fetchTodayForecastFor(_ location: Coordinates) async throws -> [Forecast] {
        return try await weatherRepository.fetchForecastBy(location, numberOfForecasts: numberOfForecasts)
    }
    
    func fetchImageFor(_ weather: Weather) async throws -> Data {
        Data()//try await weatherRepository.fetchImageWith(weather.id)
    }
    
    enum WeatherUseCaseImplError: Error {
        case locationUnavailable
    }
}
