//
//  WeatherRepositoryImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct WeatherRepositoryImpl: WeatherRepository {

    let apiClient: ApiClient
    let imageLoader: ImageLoader
    
    func fetchWeatherBy(_ coordinates: Coordinates) async throws -> Weather {
        try await apiClient.fetchWeatherBy(coordinates)
    }
    
    func fetchWeatherBy(_ cityName: String) async throws -> Weather {
        try await apiClient.fetchWeatherBy(cityName)
    }
    
    func fetchImageWith(_ iconId: String) async throws -> Data {
        try await imageLoader.fetchImageWith(iconId)
    }
}
