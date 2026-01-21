//
//  ApiClientImpl.swift
//  WeatherApp
//
//  Created by maomar on 02/10/25.
//

import Foundation

protocol NetworkConfiguration {
    var apiBaseURL: URL { get }
    var apiKey: String { get }
}

struct NetworkConfigurationImpl: NetworkConfiguration {
    let apiBaseURL: URL
    let apiKey: String

    private let baseUrlKey = "API_BASE_URL"
    private let apiKeyKey = "API_KEY"

    init() throws {
        if let url = Bundle.main.url(forResource: "Info", withExtension: "plist"),
           let dict = NSDictionary(contentsOf: url) as? [String: Any],
           let urlString = dict[baseUrlKey] as? String,
           let url = URL(string: urlString),
           let apiKey = dict[apiKeyKey] as? String {
            apiBaseURL = url
            self.apiKey = apiKey
        } else {
            throw NetworkConfigurationImplError.cannotInitializeNetworkConfiguration
        }
    }

    enum NetworkConfigurationImplError: Error {
        case cannotInitializeNetworkConfiguration
    }
}

extension URLSession: NetworkSession {}

struct ApiClientImpl: ApiClient {

    private let baseURL: URL
    private let apiKey: String
    private let weatherEndPoint = "weather"
    private let forecastEndPoint = "forecast"
    private let networkSession: NetworkSession

    init(networkSession: NetworkSession, networkConfiguration: NetworkConfiguration) throws {
        self.baseURL = networkConfiguration.apiBaseURL
        self.apiKey = networkConfiguration.apiKey
        self.networkSession = networkSession
    }

    func fetchForecastBy(_ coordinates: Coordinates, numberOfForecasts: Int) async throws -> [Forecast] {
        return try await fetchForecast(.byCoordinates(coordinates), numberOfForecasts: numberOfForecasts)
    }

    private func check(_ response: URLResponse) throws {
        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            if isRequestSuccessful(statusCode: statusCode) {
                return
            }
            try throwError(statusCode)
        }
    }

    private func isRequestSuccessful(statusCode: Int) -> Bool {
        return (200...299).contains(statusCode)
    }

    private func throwError(_ statusCode: Int) throws {
        switch statusCode {
        case 400...499:
            throw ApiClientImplError.requestError(statusCode)
        case 500...599:
            throw ApiClientImplError.serverError(statusCode)
        default:
            throw ApiClientImplError.httpError(statusCode)
        }
    }
    
    private func fetchForecast(_ mode: FetchMode, numberOfForecasts: Int) async throws -> [Forecast] {
        let url = baseURL.appendingPathComponent(forecastEndPoint)
        
        let apiCodeQueryItem = URLQueryItem(name: "appId", value: apiKey)
        
        var queryItems = buildQueryItems(for: mode)
        
        queryItems.append(URLQueryItem(name: "cnt", value: numberOfForecasts.description))
        
        queryItems.append(apiCodeQueryItem)
        
        let request = URLRequest(url: url.appending(queryItems: queryItems))
        
        let (data, response) = try await networkSession.data(for: request)

        try check(response)

        return try JSONDecoder().decode(ForecastQueryResponse.self, from: data).toForecast()
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

        let (data, response) = try await networkSession.data(for: request)

        try check(response)

        return try JSONDecoder().decode(WeatherQueryResponse.self, from: data).toWeather()
    }

    private func buildQueryItems(for mode: FetchMode) -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: "units", value: "metric")]  // TODO: - get units from system settings
        switch mode {
        case .byCityName(let cityName):
            queryItems.append(URLQueryItem(name: "q", value: cityName))
        case .byCoordinates(let coordinates):
            queryItems.append(contentsOf: [
                URLQueryItem(name: "lat", value: coordinates.latitude.description),
                URLQueryItem(name: "lon", value: coordinates.longitude.description)
            ])
        }
        return queryItems
    }

    private enum FetchMode {
        case byCityName(String)
        case byCoordinates(Coordinates)
    }
    
    enum ApiClientImplError: Error {
        case cannotInitializeClient
        case httpError(Int)
        case requestError(Int)
        case serverError(Int)
    }
}

