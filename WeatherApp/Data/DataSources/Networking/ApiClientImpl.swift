//
//  ApiClientImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct ApiClientImpl: ApiClient {
    
    private let baseURL: URL = URL(string: "https://api.openweathermap.org/data/2.5/")!
    private let apiKey: String = "d01b2c5449aaa2687f90bc71e092aaea"  // TODO: - get api key from config
    private let weatherEndPoint = "weather"
    
    func fetchWeatherBy(_ coordinates: Coordinates) async throws -> Weather {
        try await fetchWeather(.byCoordinates(coordinates))
    }
    
    func fetchWeatherBy(_ cityName: String) async throws -> Weather {
        try await fetchWeather(.byCityName(cityName))
    }
        
    private func fetchWeather(_ mode: FetchMode) async throws -> Weather {
        let url = baseURL.appendingPathComponent(weatherEndPoint)
            
        let apiCodeQueryItem = URLQueryItem(name: "appId", value: apiKey)
        
        var queryItems = buildQueryItems(for: mode)
        
        queryItems.append(apiCodeQueryItem)
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(ApiQueryResponse.self, from: data).toWeather()
    }
    
    private func buildQueryItems(for mode: FetchMode) -> [URLQueryItem] {
        switch mode {
            case .byCityName(let cityName):
            return [URLQueryItem(name: "q", value: cityName)]
        case .byCoordinates(let coordinates):
            return [URLQueryItem(name: "lat", value: coordinates.latitude.description),
            URLQueryItem(name: "lat", value: coordinates.longitude.description)]
        }
    }
    
    private enum FetchMode {
        case byCityName(String)
        case byCoordinates(Coordinates)
    }
}
