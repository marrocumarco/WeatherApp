//
//  NetworkConfigurationImpl.swift
//  WeatherApp
//
//  Created by marrocumarco on 21/01/2026.
//

import Foundation

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
