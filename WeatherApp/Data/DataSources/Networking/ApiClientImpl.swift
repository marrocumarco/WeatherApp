//
//  ApiClientImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

struct ApiClientImpl: ApiClient {

    private let baseUrlKey = "API_BASE_URL"
    private let apiKeyKey = "API_KEY"
    private let baseURL: URL
    private let apiKey: String
    private let weatherEndPoint = "weather"

    init() throws {
        if let url = Bundle.main.url(forResource: "Info", withExtension: "plist"),
            let dict = NSDictionary(contentsOf: url) as? [String: Any],
            let urlString = dict[baseUrlKey] as? String,
            let url = URL(string: urlString),
            let apiKey = dict[apiKeyKey] as? String
        {
            baseURL = url
            self.apiKey = apiKey
        } else {
            throw ApiClientImplError.cannotInitializeClient
        }
    }
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

        let request = URLRequest(url: url.appending(queryItems: queryItems))

        let (data, response) = try await URLSession.shared.data(for: request)

        // TODO check response for network errors

        return try JSONDecoder().decode(ApiQueryResponse.self, from: data).toWeather()
    }

    private func buildQueryItems(for mode: FetchMode) -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: "units", value: "metric")]  // TODO: - get units from system settings
        switch mode {
        case .byCityName(let cityName):
            queryItems.append(URLQueryItem(name: "q", value: cityName))
        case .byCoordinates(let coordinates):
            queryItems.append(contentsOf: [
                URLQueryItem(name: "lat", value: coordinates.latitude.description),
                URLQueryItem(name: "lon", value: coordinates.longitude.description),
            ])
        }
        return queryItems
    }

    private enum FetchMode {
        case byCityName(String)
        case byCoordinates(Coordinates)
    }
    
    private enum ApiClientImplError: Error {
        case cannotInitializeClient
    }
}
