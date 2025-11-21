//
//  FetchForecastUseCaseImpl.swift
//  WeatherApp
//
//  Created by maomar on 21/11/25.
//

import Foundation

struct FetchForecastUseCaseImpl: FetchForecastUseCase {
    
    let weatherRepository: WeatherRepository
    let geocoder: Geocoder
    let numberOfForecasts = 8
    
    func fetchTodayForecastFor(_ location: Coordinates) async throws -> [Forecast] {
        return try await weatherRepository.fetchForecastBy(location, numberOfForecasts: numberOfForecasts)
    }
    
    func fetchTodayForecastFor(_ cityName: String) async throws -> [Forecast] {
        let coordinates = try await geocoder.getCoordinatesFrom(cityName)
        return try await fetchTodayForecastFor(coordinates)
    }
}
